package com.example.carrentweb.Boundary;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet("/images/*")
public class ImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filename = request.getPathInfo();
        if (filename != null && filename.startsWith("/")) {
            filename = filename.substring(1);
        }

        System.out.println("ImageServlet: Requesting file: " + filename);

        // Use servlet context to get the real path of the uploads directory
        String uploadDirPath = getServletContext().getRealPath("/uploads/vehicles/");
        System.out.println("ImageServlet: Upload directory path: " + uploadDirPath);

        if (uploadDirPath == null) {
            System.err.println("ImageServlet: Upload directory path is null");
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Upload directory not found");
            return;
        }

        Path uploadDir = Paths.get(uploadDirPath);
        // Ensure directory exists
        try {
            Files.createDirectories(uploadDir);
            System.out.println("ImageServlet: Upload directory created/verified: " + uploadDir);
        } catch (Exception e) {
            System.err.println("ImageServlet: Cannot create upload directory: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Cannot create upload directory");
            return;
        }

        Path file = uploadDir.resolve(filename);
        System.out.println("ImageServlet: Looking for file: " + file);

        if (Files.exists(file) && Files.isRegularFile(file)) {
            System.out.println("ImageServlet: File found, serving: " + file);
            String mimeType = getServletContext().getMimeType(filename);
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }
            response.setContentType(mimeType);
            response.setContentLengthLong(Files.size(file));
            Files.copy(file, response.getOutputStream());
        } else {
            System.err.println("ImageServlet: File not found: " + file + " (exists: " + Files.exists(file) + ", isRegularFile: " + Files.isRegularFile(file) + ")");
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}