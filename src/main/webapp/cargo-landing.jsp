<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Smart Vehicle Booking & Fleet Management Platform. Streamline your rental operations with comprehensive booking, fleet management, financial reporting, and customer insights.">
    <meta name="keywords" content="vehicle booking, fleet management, car rental software, fleet tracking, rental management system, vehicle reservation">
    <meta name="author" content="CarGO">
    <meta name="robots" content="index, follow">

    <!-- Language Support -->
    <meta http-equiv="Content-Language" content="si,en">

    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="Smart Vehicle Booking & Fleet Management">
    <meta property="og:description" content="Comprehensive platform for vehicle booking and fleet management. Streamline operations with advanced features for booking, tracking, and analytics.">
    <meta property="og:type" content="website">
    <meta property="og:url" content="${pageContext.request.contextPath}/">
    <meta property="og:image" content="https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=1200&h=630&fit=crop">
    
    <!-- Twitter Card Meta Tags -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="Smart Vehicle Booking & Fleet Management">
    <meta name="twitter:description" content="Comprehensive platform for vehicle booking and fleet management with advanced analytics and customer insights.">
    <meta name="twitter:image" content="https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=1200&h=630&fit=crop">
    
    <!-- Structured Data -->
    <script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@type": "Organization",
        "name": "CarGO",
        "description": "Smart Vehicle Booking & Fleet Management Platform",
        "url": "${pageContext.request.contextPath}/",
        "logo": "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=200&h=200&fit=crop",
        "contactPoint": {
            "@type": "ContactPoint",
            "telephone": "+94 11 123 4567",
            "contactType": "customer service"
        },
        "address": {
            "@type": "PostalAddress",
            "streetAddress": "KU-07 SE2030, SLIIT Kandy",
            "addressLocality": "Kandy",
            "addressRegion": "Central Province",
            "postalCode": "20000",
            "addressCountry": "LK"
        },
        "serviceType": "Vehicle Rental Management",
        "areaServed": "Sri Lanka"
    }
    </script>
    
    <title>Smart Vehicle Booking & Fleet Management Platform</title>

    <!-- Preload critical resources -->
    <link rel="preload" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&family=Noto+Sans+Sinhala:wght@100;200;300;400;500;600;700;800;900&display=swap" as="style">
    <link rel="preload" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" as="style">

    <!-- DNS prefetch for external resources -->
    <link rel="dns-prefetch" href="//fonts.googleapis.com">
    <link rel="dns-prefetch" href="//images.unsplash.com">
    <link rel="dns-prefetch" href="//cdn.jsdelivr.net">

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>🚗</text></svg>">

    <!-- Stylesheets -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&family=Noto+Sans+Sinhala:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary-orange: #CC5500; /* Burnt orange */
            --primary-orange-light: #E25822;
            --primary-orange-dark: #A04000;
            --accent-red: #8B0000; /* Dirty red */
            --accent-red-light: #A0522D;
            --accent-red-dark: #660000;
            --aluminum: #C0C0C0; /* Harsh aluminum */
            --aluminum-light: #D3D3D3;
            --aluminum-dark: #A8A8A8;
            --text-black: #000000;
            --text-dark: #333333;
            --text-light: #666666;
            --text-white: #ffffff;
            --bg-white: #ffffff;
            --bg-gray: #f5f5f5;
            --bg-light-gray: #f0f0f0;
            --border-color: #e0e0e0;
            --shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --gradient-orange: linear-gradient(135deg, var(--primary-orange) 0%, var(--primary-orange-dark) 100%);
            --gradient-hero: linear-gradient(135deg, #f5f5f5 0%, #f0f0f0 100%);
            --gradient-card: linear-gradient(135deg, #ffffff 0%, #f5f5f5 100%);
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', 'Noto Sans Sinhala', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            font-size: 14px;
            line-height: 1.7;
            color: var(--text-dark);
            background: var(--bg-gray);
            background-image:
                radial-gradient(circle at 25% 25%, rgba(255, 45, 45, 0.03) 0%, transparent 50%),
                radial-gradient(circle at 75% 75%, rgba(255, 45, 45, 0.03) 0%, transparent 50%);
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            scroll-behavior: smooth;
            min-height: 100vh;
        }

        /* Loading Animation */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--bg-white);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            transition: opacity 0.5s ease;
        }

        .loading-spinner {
            width: 50px;
            height: 50px;
            border: 4px solid var(--border-color);
            border-top: 4px solid var(--accent-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Header & Navigation */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            padding: 1rem 0;
            transition: all 0.3s ease;
        }

        .header.scrolled {
            padding: 0.5rem 0;
            background: rgba(255, 255, 255, 0.98);
        }

        .navbar-brand {
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--text-black) !important;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
        }

        .navbar-brand .logo {
            width: 45px;
            height: 45px;
            background: var(--gradient-red);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            font-weight: 700;
            box-shadow: var(--shadow);
        }

        .navbar-nav .nav-link {
            font-weight: 500;
            color: var(--text-black) !important;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
            border-radius: 8px;
            margin: 0 0.25rem;
            position: relative;
        }

        .navbar-nav .nav-link:hover {
            color: var(--primary-orange) !important;
            background: rgba(204, 85, 0, 0.08);
        }

        .contact-btn {
            color: var(--primary-orange) !important;
            font-weight: 600;
        }

        .admin-btn {
            color: var(--aluminum) !important;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .admin-btn:hover {
            color: var(--primary-orange) !important;
            background: rgba(204, 85, 0, 0.08);
        }

        .btn-signup {
            background: var(--gradient-orange);
            color: var(--text-white);
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            box-shadow: 0 4px 15px rgba(204, 85, 0, 0.3);
            margin-left: 1rem;
        }

        .btn-signup:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(204, 85, 0, 0.4);
            color: var(--text-white);
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.3)),
                        url('https://images.unsplash.com/photo-1555215695-3004980ad54e?w=1920&h=1080&fit=crop&crop=center') center/cover no-repeat;
            padding: 150px 0 100px;
            position: relative;
            min-height: 100vh;
            display: flex;
            align-items: center;
            color: white;
        }

        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(204, 85, 0, 0.1) 0%, rgba(0, 0, 0, 0.4) 100%);
            z-index: 1;
        }

        .hero .container {
            position: relative;
            z-index: 2;
        }

        .hero-content {
            text-align: center;
            max-width: 800px;
            margin: 0 auto 3rem;
        }

        .hero-title {
            font-size: clamp(3rem, 6vw, 5rem);
            font-weight: 900;
            color: white;
            line-height: 1.1;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        .hero-description {
            font-size: 1.25rem;
            color: rgba(255, 255, 255, 0.9);
            line-height: 1.6;
            margin-bottom: 2rem;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        }

        .btn-get-started {
            background: var(--gradient-orange);
            color: var(--text-white);
            border: none;
            padding: 1rem 2.5rem;
            border-radius: 30px;
            font-weight: 700;
            font-size: 1.125rem;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            box-shadow: 0 8px 25px rgba(204, 85, 0, 0.4);
        }

        .btn-get-started:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(204, 85, 0, 0.5);
            color: var(--text-white);
        }

        .btn-outline-started {
            background: transparent;
            color: var(--primary-orange);
            border: 2px solid var(--primary-orange);
            padding: 1rem 2.5rem;
            border-radius: 30px;
            font-weight: 700;
            font-size: 1.125rem;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-outline-started:hover {
            background: var(--primary-orange);
            color: var(--text-white);
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(204, 85, 0, 0.3);
        }

        .hero-image {
            text-align: center;
        }

        .hero-image img {
            max-width: 100%;
            height: auto;
            box-shadow: var(--shadow-lg);
        }

        .highlight-card {
            background: var(--bg-white);
            border-radius: 16px;
            padding: 2rem;
            text-align: center;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            margin-bottom: 1rem;
        }

        .highlight-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .highlight-icon {
            width: 60px;
            height: 60px;
            background: var(--gradient-orange);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            margin: 0 auto 1rem;
        }

        .highlight-content h3 {
            font-size: 2rem;
            font-weight: 800;
            color: var(--text-black);
            margin-bottom: 0.5rem;
        }

        .highlight-content p {
            color: var(--text-light);
            font-weight: 500;
        }

        .hero-gallery {
            margin-top: 3rem;
        }

        .gallery-item {
            position: relative;
            overflow: hidden;
            border-radius: 12px;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            height: 150px;
        }

        .gallery-item:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: var(--shadow-lg);
        }

        .gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .gallery-item:hover img {
            transform: scale(1.1);
        }

        @media (max-width: 768px) {
            .gallery-item {
                height: 120px;
                margin-bottom: 1rem;
            }
        }

        /* Sections */
        .section {
            padding: 100px 0;
            position: relative;
        }

        .section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.02) 0%, rgba(248, 250, 252, 0.05) 100%);
            z-index: -1;
            border-radius: 0 0 50px 50px;
        }

        .section-title {
            font-size: clamp(1.75rem, 3.5vw, 2.5rem);
            font-weight: 700;
            color: var(--text-black);
            text-align: center;
            margin-bottom: 4rem;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: var(--gradient-orange);
            border-radius: 2px;
        }

        /* Fleet Section */
        .fleet-section {
            background: var(--bg-gray);
            background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,45,45,0.03)"/><circle cx="75" cy="75" r="1" fill="rgba(255,45,45,0.03)"/><circle cx="50" cy="10" r="0.5" fill="rgba(255,45,45,0.02)"/><circle cx="10" cy="50" r="0.5" fill="rgba(255,45,45,0.02)"/><circle cx="90" cy="30" r="0.5" fill="rgba(255,45,45,0.02)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
        }

        .section-subtitle {
            font-size: 1.125rem;
            color: var(--text-light);
            margin-bottom: 3rem;
        }

        .featured-banner {
            background: linear-gradient(135deg, var(--primary-orange) 0%, var(--text-black) 100%);
            border-radius: 20px;
            padding: 3rem;
            color: white;
            box-shadow: var(--shadow-lg);
        }

        .featured-content h3 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
        }

        .featured-content p {
            font-size: 1.125rem;
            opacity: 0.9;
            margin-bottom: 1.5rem;
        }

        .featured-price .price {
            font-size: 1.5rem;
            font-weight: 700;
            color: #ffd700;
        }

        .btn-rent-featured {
            background: white;
            color: var(--primary-orange);
            border: none;
            padding: 1rem 2rem;
            border-radius: 25px;
            font-weight: 700;
            font-size: 1.125rem;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin-top: 1rem;
        }

        .btn-rent-featured:hover {
            background: #f8f9fa;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        }

        .car-card {
            background: var(--bg-white);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            height: 100%;
        }

        .car-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .car-image {
            position: relative;
            height: 200px;
            overflow: hidden;
        }

        .car-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .car-card:hover .car-image img {
            transform: scale(1.05);
        }

        .availability-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
            color: white;
        }

        .availability-badge.available {
            background: #10b981;
        }

        .availability-badge.unavailable {
            background: #ef4444;
        }

        .car-content {
            padding: 1.5rem;
        }

        .car-name {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }

        .car-type {
            color: var(--text-light);
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }

        .car-description {
            color: var(--text-light);
            font-size: 0.9rem;
            margin-bottom: 1rem;
            line-height: 1.5;
        }

        .car-price .price {
            font-size: 1.125rem;
            font-weight: 700;
            color: var(--primary-orange);
        }

        .btn-rent {
            background: var(--gradient-orange);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            width: 100%;
            text-align: center;
            margin-top: 1rem;
        }

        .btn-rent:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(204, 85, 0, 0.3);
            color: white;
        }

        .btn-view-all {
            background: transparent;
            color: var(--primary-orange);
            border: 2px solid var(--primary-orange);
            padding: 1rem 2rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-view-all:hover {
            background: var(--primary-orange);
            color: white;
            transform: translateY(-2px);
        }

        .car-card {
            position: relative;
        }

        .car-card .card-img-top {
            height: 280px;
            object-fit: cover;
            transition: transform 0.4s ease;
            background: var(--bg-gray);
        }

        .car-card:hover .card-img-top {
            transform: scale(1.05);
        }

        .card-body {
            padding: 2rem;
        }

        .card-title {
            font-size: 1.375rem;
            font-weight: 600;
            color: var(--text-black);
            margin-bottom: 1rem;
        }

        .card-text {
            color: var(--text-light);
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        /* Lazy Loading Placeholder */
        .lazy-placeholder {
            background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
            background-size: 200% 100%;
            animation: loading 1.5s infinite;
        }

        @keyframes loading {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }

        /* Buttons */
        .btn {
            font-weight: 600;
            border-radius: 16px;
            padding: 0.875rem 2rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background: var(--gradient-orange);
            color: var(--text-white);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(204, 85, 0, 0.3);
            color: var(--text-white);
        }

        .btn-outline-primary {
            border: 2px solid var(--accent-red);
            color: var(--accent-red);
            background: transparent;
        }

        .btn-outline-primary:hover {
            background: var(--accent-red);
            color: var(--text-white);
            transform: translateY(-2px);
        }

        /* Features Section */
        .features {
            background: var(--bg-gray);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            background: var(--gradient-orange);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            margin: 0 auto 1.5rem;
            box-shadow: var(--shadow);
        }

        /* Stats Section */
        .stats {
            background: var(--primary-orange);
            color: var(--text-white);
        }

        .stat-item {
            text-align: center;
            padding: 2rem;
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 800;
            background: var(--gradient-orange);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display: block;
        }

        .stat-label {
            font-size: 1.125rem;
            opacity: 0.9;
            margin-top: 0.5rem;
        }

        /* Footer */
        .footer {
            background: var(--text-black);
            color: #94a3b8;
            padding: 80px 0 40px;
        }

        .footer h5 {
            color: var(--text-white);
            font-weight: 600;
            margin-bottom: 1.5rem;
        }

        .footer a {
            color: #94a3b8;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer a:hover {
            color: var(--primary-orange-light);
        }

        .social-links a {
            display: inline-block;
            width: 45px;
            height: 45px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            text-align: center;
            line-height: 45px;
            margin-right: 0.75rem;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            background: var(--gradient-orange);
            transform: translateY(-1px);
            box-shadow: var(--shadow);
        }

        /* Badges */
        .badge {
            font-size: 0.875rem;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 20px;
        }

        .badge-available {
            background: linear-gradient(135deg, var(--secondary-color), var(--secondary-dark));
            color: white;
        }

        .badge-unavailable {
            background: linear-gradient(135deg, var(--accent-color), var(--accent-dark));
            color: white;
        }

        /* Contact Cards */
        .contact-card {
            background: var(--bg-white);
            border-radius: 16px;
            padding: 2rem 1.5rem;
            text-align: center;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            height: 100%;
        }

        .contact-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .contact-icon {
            width: 70px;
            height: 70px;
            background: var(--gradient-orange);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            margin: 0 auto 1.5rem;
        }

        .contact-card h5 {
            font-weight: 700;
            color: var(--text-black);
            margin-bottom: 1rem;
        }

        .contact-card p {
            color: var(--text-light);
            line-height: 1.6;
        }

        .contact-section {
            background: var(--bg-white);
            background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="contact-pattern" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="2" fill="rgba(255,45,45,0.05)"/><circle cx="90" cy="90" r="2" fill="rgba(255,45,45,0.05)"/><circle cx="50" cy="20" r="1" fill="rgba(255,45,45,0.03)"/><circle cx="20" cy="80" r="1" fill="rgba(255,45,45,0.03)"/></pattern></defs><rect width="100" height="100" fill="url(%23contact-pattern)"/></svg>');
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero {
                padding: 100px 0 60px;
            }

            .hero-title {
                font-size: clamp(2rem, 6vw, 3rem);
            }

            .hero-description {
                font-size: 1rem;
            }

            .btn-get-started {
                padding: 0.875rem 2rem;
                font-size: 1rem;
            }

            .highlight-card {
                padding: 1.5rem;
            }

            .highlight-icon {
                width: 50px;
                height: 50px;
                font-size: 1.25rem;
            }

            .featured-banner {
                padding: 2rem;
            }

            .featured-content h3 {
                font-size: 2rem;
            }

            .section {
                padding: 80px 0;
            }

            .navbar-brand {
                font-size: 1.5rem;
            }

            .navbar-brand .logo {
                width: 35px;
                height: 35px;
                font-size: 1.25rem;
            }

            .btn-signup {
                margin-left: 0.5rem;
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }
        }

        @media (max-width: 576px) {
            .hero {
                padding: 80px 0 40px;
            }

            .hero-content {
                margin-bottom: 2rem;
            }

            .car-content {
                padding: 1rem;
            }

            .car-name {
                font-size: 1.1rem;
            }

            .btn-rent {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }

            .contact-card {
                padding: 1.5rem 1rem;
            }

            .contact-icon {
                width: 60px;
                height: 60px;
                font-size: 1.25rem;
            }
        }

        /* Star Rating Styles */
        .rating-stars {
            display: flex;
            gap: 5px;
        }

        .rating-stars input[type="radio"] {
            display: none;
        }

        .rating-stars label {
            font-size: 2rem;
            color: #ddd;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .rating-stars input[type="radio"]:checked ~ label,
        .rating-stars label:hover,
        .rating-stars label:hover ~ label {
            color: #ffc107;
        }

        .rating-stars input[type="radio"]:checked ~ label:before,
        .rating-stars label:hover:before,
        .rating-stars label:hover ~ label:before {
            content: '\f005';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        /* Hover lift effect for promotion cards */
        .hover-lift:hover {
            transform: translateY(-8px) !important;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1) !important;
        }
    </style>
</head>
<body>
    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-spinner"></div>
    </div>

    <!-- Header & Navigation -->
    <header class="header" id="header">
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <a class="navbar-brand" href="HomeServlet">
                    <div class="logo">🚗</div>
                    CarGO
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link" href="#home">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#vehicles">Services</a></li>
                        <li class="nav-item"><a class="nav-link" href="#vehicles">Cars</a></li>
                        <li class="nav-item"><a class="nav-link" href="#contact">Pricing</a></li>
                        <li class="nav-item"><a class="nav-link" href="#contact">About</a></li>
                        <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
                    </ul>
                    <ul class="navbar-nav ms-auto align-items-center">
                        <li class="nav-item"><a class="nav-link admin-btn" data-bs-toggle="modal" data-bs-target="#adminLoginModal">Admin</a></li>
                        <c:if test="${empty sessionScope.username}">
                            <li class="nav-item"><a class="btn-signup" data-bs-toggle="modal" data-bs-target="#registerModal">Sign Up</a></li>
                        </c:if>
                        <c:if test="${not empty sessionScope.username}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    ${sessionScope.userFullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><span class="dropdown-item-text text-muted">Role: ${sessionScope.role}</span></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="HomeServlet?page=customer-booking">My Bookings</a></li>
                                    <li><a class="dropdown-item" href="HomeServlet?page=customer-feedback">Feedback</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="AuthController?action=logout">Logout</a></li>
                                </ul>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <!-- Hero Section -->
    <section class="hero" id="home">
        <div class="hero-overlay"></div>
        <div class="container">
            <div class="hero-content">
                <c:choose>
                    <c:when test="${not empty sessionScope.username}">
                        <h1 class="hero-title">Welcome back, ${sessionScope.userFullName}!</h1>
                        <p class="hero-description">Ready for your next adventure? Discover our premium fleet and book your perfect ride in minutes.</p>
                        <div class="d-flex gap-3 flex-wrap">
                            <a href="#vehicles" class="btn-get-started">Browse Vehicles</a>
                            <a href="<c:choose><c:when test="${sessionScope.role == 'admin'}">AdminServlet</c:when><c:otherwise>HomeServlet?page=customer-dashboard</c:otherwise></c:choose>" class="btn-outline-started">My Dashboard</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <h1 class="hero-title">Your Journey, Your Car, Your Way</h1>
                        <p class="hero-description">Experience the freedom of the open road with our extensive fleet of luxury and economy vehicles. Book online in minutes and enjoy hassle-free rentals.</p>
                        <div class="d-flex gap-3 flex-wrap">
                            <a href="#vehicles" class="btn-get-started">Get Started</a>
                            <a data-bs-toggle="modal" data-bs-target="#loginModal" class="btn-outline-started">Customer Dashboard</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="row mt-5">
                <div class="col-md-4">
                    <div class="highlight-card">
                        <div class="highlight-icon">
                            <i class="fas fa-car"></i>
                        </div>
                        <div class="highlight-content">
                            <h3>50+ Cars Available</h3>
                            <p>Wide selection for every need</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="highlight-card">
                        <div class="highlight-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="highlight-content">
                            <h3>Trusted by 10K+ Users</h3>
                            <p>Satisfied customers worldwide</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="highlight-card">
                        <div class="highlight-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="highlight-content">
                            <h3>Easy Booking</h3>
                            <p>Book in minutes, drive away</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Promotions Section -->
    <c:if test="${not empty promotions}">
        <section class="section" id="promotions" style="background: var(--bg-white);">
            <div class="container">
                <div class="text-center mb-5">
                    <h2 class="section-title">Special Offers & Promotions</h2>
                    <p class="section-subtitle">Don't miss out on our latest deals and exclusive offers</p>
                </div>
                <div class="row g-4">
                    <c:forEach var="promo" items="${promotions}">
                        <div class="col-lg-4 col-md-6">
                            <div class="card hover-lift">
                                <div class="card-body text-center">
                                    <div class="card-icon text-warning mb-3">
                                        <i class="fas fa-tags fa-3x"></i>
                                    </div>
                                    <h5 class="card-title">${promo.title}</h5>
                                    <c:if test="${not empty promo.badge}">
                                        <span class="badge bg-warning text-dark mb-2">${promo.badge}</span>
                                    </c:if>
                                    <p class="card-text">${promo.description}</p>
                                    <c:if test="${not empty promo.validTill}">
                                        <small class="text-muted">Valid until: ${promo.validTill}</small>
                                    </c:if>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.username}">
                                            <a href="#booking" class="btn btn-primary mt-3">
                                                <i class="fas fa-calendar-check me-2"></i>Book Now
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a data-bs-toggle="modal" data-bs-target="#loginModal" class="btn btn-primary mt-3">
                                                <i class="fas fa-sign-in-alt me-2"></i>Login to Book
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:if>

    <!-- Fleet Section -->
    <section class="section fleet-section" id="vehicles">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title">Our Impressive Fleet</h2>
                <p class="section-subtitle">Choose from our wide range of premium vehicles for your perfect journey</p>
            </div>

            <!-- Featured Car Banner -->
            <div class="featured-banner mb-5">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <div class="featured-content">
                            <h3>Luxury Sedan Collection</h3>
                            <p>Experience ultimate comfort and style with our premium sedan lineup. Perfect for business trips or special occasions.</p>
                            <div class="featured-price">
                                <span class="price">Starting at Rs.10000/day</span>
                            </div>
                            <a href="#booking" class="btn-rent-featured">Rent Now</a>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="featured-image">
                            <img src="https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=600&h=350&fit=crop&crop=center" alt="Featured Luxury Car" class="img-fluid rounded">
                        </div>
                    </div>
                </div>
            </div>

            <!-- Car Grid -->
            <div class="row g-4">
                <c:forEach var="car" items="${carList}" varStatus="status">
                     <c:if test="${status.index < 6}"> <!-- Show first 6 cars -->
                     <div class="col-lg-4 col-md-6">
                         <div class="car-card vehicle-item" data-type="${car.vehicleType}" data-availability="${car.available == true or car.available == 1 ? 'available' : 'unavailable'}">
                            <div class="car-image">
                                <img src="${car.imageUrl != null && car.imageUrl != '' ? car.imageUrl : 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=400&h=250&fit=crop&crop=center'}"
                                     alt="${car.vehicleName}" class="img-fluid">
                                <c:if test="${car.available == true or car.available == 1}">
                                    <div class="availability-badge available">Available</div>
                                </c:if>
                                <c:if test="${car.available != true and car.available != 1}">
                                    <div class="availability-badge unavailable">Unavailable</div>
                                </c:if>
                            </div>
                            <div class="car-content">
                                <h4 class="car-name">${car.vehicleName}</h4>
                                <p class="car-type">${car.vehicleType}</p>
                                <p class="car-description">Comfortable and reliable vehicle perfect for your travels.</p>
                                <div class="car-price">
                                    <span class="price">Starting at $${car.dailyPrice}/day</span>
                                </div>
                                <c:choose>
                                    <c:when test="${not empty sessionScope.username}">
                                        <a href="#booking" class="btn-rent" onclick="prefillBooking('${car.vehicleId}','${car.vehicleName}')">
                                            <i class="fas fa-key me-2"></i>Rent Now
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a data-bs-toggle="modal" data-bs-target="#loginModal" class="btn-rent">
                                            <i class="fas fa-sign-in-alt me-2"></i>Login to Rent
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    </c:if>
                </c:forEach>
            </div>

            <div class="text-center mt-5">
                <a href="#all-vehicles" class="btn-view-all">View All Vehicles</a>
            </div>
        </div>
    </section>

    <!-- Booking Section -->
    <c:if test="${not empty sessionScope.username}">
    <section class="section" id="booking" style="background: var(--bg-white);">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title">Book Your Vehicle</h2>
                <p class="section-subtitle">Complete your booking details below</p>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-body p-4">
                            <form action="BookingController" method="post" onsubmit="showBooked()">
                                <input type="hidden" name="action" value="create">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="fas fa-calendar-alt me-2"></i>Pick-up Date
                                        </label>
                                        <input type="date" class="form-control" name="pickupDate" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="fas fa-calendar-alt me-2"></i>Return Date
                                        </label>
                                        <input type="date" class="form-control" name="returnDate" required>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">
                                            <i class="fas fa-car me-2"></i>Select Vehicle
                                        </label>
                                        <select id="bookingCar" class="form-select" name="vehicleId" required>
                                            <option value="">Choose a vehicle...</option>
                                            <c:forEach var="car" items="${carList}">
                                                <option value="${car.vehicleId}">${car.vehicleName} - $${car.dailyPrice}/day</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-12 d-grid">
                                        <button type="submit" class="btn btn-primary btn-lg">
                                            <i class="fas fa-check me-2"></i>Confirm Booking
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    </c:if>


    <!-- Testimonials Section -->
    <section class="section" id="testimonials" style="background: var(--bg-gray);">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title">What Our Customers Say</h2>
                <p class="section-subtitle">Real feedback from our valued customers</p>
                <div class="text-center mb-4">
                    <c:if test="${not empty sessionScope.username && sessionScope.role == 'customer'}">
                        <a data-bs-toggle="modal" data-bs-target="#customerFeedbackModal" class="btn btn-primary">
                            <i class="fas fa-comments me-2"></i>Share Your Feedback
                        </a>
                    </c:if>
                    <c:if test="${empty sessionScope.username}">
                        <a data-bs-toggle="modal" data-bs-target="#loginModal" class="btn btn-outline-primary">
                            <i class="fas fa-sign-in-alt me-2"></i>Login to Share Feedback
                        </a>
                    </c:if>
                </div>
            </div>
            <!-- Recent Customer Feedback -->
            <div class="row mt-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Recent Customer Feedback</h5>
                            <span class="badge bg-primary">${recentFeedback != null ? recentFeedback.size() : 0} Reviews</span>
                        </div>
                        <div class="card-body">
                            <c:if test="${empty recentFeedback}">
                                <div class="text-center py-5">
                                    <h6 class="text-muted mb-3">No Reviews Yet</h6>
                                    <p class="text-muted">Be the first to share your experience with CarGO!</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty recentFeedback}">
                                <div class="row g-3">
                                    <c:forEach var="feedback" items="${recentFeedback}">
                                        <div class="col-md-6">
                                            <div class="card feedback-card h-100">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                        <div class="rating-stars">
                                                            <c:forEach begin="1" end="5" var="i">
                                                                <c:choose>
                                                                    <c:when test="${i <= feedback.rating}">
                                                                        ⭐
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ☆
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>
                                                        </div>
                                                        <small class="text-muted">${feedback.dateSubmitted}</small>
                                                    </div>
                                                    <c:if test="${not empty feedback.bookingId}">
                                                        <p class="text-muted small mb-2">Booking #${feedback.bookingId}</p>
                                                    </c:if>
                                                    <p class="card-text">${feedback.comments}</p>
                                                    <c:if test="${not empty feedback.adminResponse}">
                                                        <div class="mt-3 p-3 bg-light rounded">
                                                            <small class="text-muted fw-semibold">Admin Response:</small>
                                                            <p class="mb-0 mt-1">${feedback.adminResponse}</p>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </section>


    <!-- Contact Section -->
    <section class="section contact-section" id="contact">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title">Get In Touch</h2>
                <p class="section-subtitle">Ready to start your journey? Contact us today.</p>
            </div>
            <div class="row g-4 justify-content-center">
                <div class="col-lg-3 col-md-6">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <h5>Visit Us</h5>
                        <p>KU-07 SE2030, SLIIT Kandy<br>Kandy, Sri Lanka</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <h5>Call Us</h5>
                        <p>+94 11 123 4567<br>Mon-Fri: 8AM-8PM</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <h5>Email Us</h5>
                        <p>info@cargo.com<br>support@cargo.com</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="d-flex align-items-center mb-3">
                        <div class="logo me-3" style="width: 40px; height: 40px; background: var(--gradient-primary); border-radius: 10px; display: flex; align-items: center; justify-content: center; color: white; font-weight: 700;">CG</div>
                        <h5 class="mb-0">CarGO</h5>
                    </div>
                    <p>Your trusted partner for premium car rentals. Experience the freedom of the open road with our exceptional service and modern fleet.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Quick Links</h6>
                    <ul class="list-unstyled">
                        <li><a href="#home">Home</a></li>
                        <li><a href="#vehicles">Vehicles</a></li>
                        <li><a href="#features">Features</a></li>
                        <li><a href="#contact">Contact</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Services</h6>
                    <ul class="list-unstyled">
                        <li><a href="#vehicles">Car Rental</a></li>
                        <li><a href="#booking">Online Booking</a></li>
                        <li><a href="#">24/7 Support</a></li>
                        <li><a href="#">Insurance</a></li>
                    </ul>
                </div>
                <div class="col-lg-4 col-md-4">
                    <h6>Contact Info</h6>
                    <ul class="list-unstyled">
                        <li><i class="fas fa-map-marker-alt me-2"></i>KU-07 SE2030, SLIIT Kandy</li>
                        <li><i class="fas fa-phone me-2"></i>081 123 4567</li>
                        <li><i class="fas fa-envelope me-2"></i>KU09SE@cargo.com</li>
                        <li><i class="fas fa-clock me-2"></i>Mon-Fri: 8AM-8PM</li>
                    </ul>
                </div>
            </div>
            <hr class="my-4" style="border-color: rgba(255,255,255,0.1);">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="mb-0">&copy; 2025 CarGO. All Rights Reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <a href="#" class="me-3">Privacy Policy</a>
                    <a href="#" class="me-3">Terms of Service</a>
                    <a href="#">Cookie Policy</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Notification Area -->
    <div class="position-fixed top-0 end-0 p-3" style="z-index: 11000;">
        <div id="notify" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <strong class="me-auto">CarGO</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body" id="notifyText">
                Notification message here
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" defer></script>
    <script defer>
        // Page Loading
        window.addEventListener('load', function() {
            const loadingOverlay = document.getElementById('loadingOverlay');
            loadingOverlay.style.opacity = '0';
            setTimeout(() => {
                loadingOverlay.style.display = 'none';
            }, 500);
        });

        // Header Scroll Effect
        window.addEventListener('scroll', function() {
            const header = document.getElementById('header');
            if (window.scrollY > 100) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        });

        // Lazy Loading Images
        const lazyImages = document.querySelectorAll('.lazy-load');
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.classList.remove('lazy-placeholder');
                    img.onload = () => {
                        img.style.opacity = '1';
                    };
                    observer.unobserve(img);
                }
            });
        });

        lazyImages.forEach(img => {
            img.style.opacity = '0';
            img.style.transition = 'opacity 0.3s';
            imageObserver.observe(img);
        });

        // Counter Animation
        const counters = document.querySelectorAll('.stat-number');
        const counterObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const counter = entry.target;
                    const target = parseInt(counter.dataset.count);
                    let current = 0;
                    const increment = target / 100;
                    const timer = setInterval(() => {
                        current += increment;
                        if (current >= target) {
                            current = target;
                            clearInterval(timer);
                        }
                        counter.textContent = Math.floor(current);
                    }, 20);
                    counterObserver.unobserve(counter);
                }
            });
        });

        counters.forEach(counter => {
            counterObserver.observe(counter);
        });

        // Vehicle Filtering
        function applyFilters() {
            const searchTerm = document.getElementById('searchInput')?.value.toLowerCase() || '';
            const typeFilter = document.getElementById('filterType')?.value || '';
            const availabilityFilter = document.getElementById('filterAvailability')?.value || '';
            
            document.querySelectorAll('.vehicle-item').forEach(item => {
                const name = item.querySelector('.card-title')?.textContent.toLowerCase() || '';
                const type = item.dataset.type || '';
                const availability = item.dataset.availability || '';
                
                let show = true;
                
                if (searchTerm && !name.includes(searchTerm)) show = false;
                if (typeFilter && type !== typeFilter) show = false;
                if (availabilityFilter && availability !== availabilityFilter) show = false;
                
                item.style.display = show ? 'block' : 'none';
            });
        }

        // Booking Functions
        function prefillBooking(vehicleId, vehicleName) {
            const select = document.getElementById('bookingCar');
            if (select) {
                select.value = vehicleId;
                showNotification(`Selected ${vehicleName} for booking.`);
                document.getElementById('booking')?.scrollIntoView({ behavior: 'smooth' });
            }
        }

        function showBooked() {
            showNotification('Your booking request has been submitted successfully!');
        }

        function showNotification(message) {
            const notifyElement = document.getElementById('notify');
            const notifyText = document.getElementById('notifyText');
            if (notifyElement && notifyText) {
                notifyText.textContent = message;
                const toast = new bootstrap.Toast(notifyElement);
                toast.show();
            }
        }

        // Smooth Scrolling for Navigation Links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Search on Enter
        document.getElementById('searchInput')?.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                applyFilters();
            }
        });

        // Auto-apply filters on change
        document.getElementById('filterType')?.addEventListener('change', applyFilters);
        document.getElementById('filterAvailability')?.addEventListener('change', applyFilters);
    </script>

    <!-- Auto-show admin promotions modal if parameter is set -->
    <c:if test="${showAdminPromotions == '1'}">
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const adminModal = new bootstrap.Modal(document.getElementById('adminPromotionModal'));
            adminModal.show();
        });
    </script>
    </c:if>

    <!-- Admin Login Modal -->
    <div class="modal fade" id="adminLoginModal" tabindex="-1" aria-labelledby="adminLoginModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="adminLoginModalLabel">Admin Login</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="AuthController" method="post">
                        <input type="hidden" name="action" value="login">
                        <input type="hidden" name="role" value="admin">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Login</button>
                        </div>
                    </form>
                    <div class="text-center mt-3">
                        <p class="mb-0">Need to create admin account? <a href="#" data-bs-toggle="modal" data-bs-target="#adminRegisterModal" data-bs-dismiss="modal">Register here</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Login Modal -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="loginModalLabel">Customer Login</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="AuthController" method="post">
                        <input type="hidden" name="action" value="login">
                        <input type="hidden" name="role" value="customer">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Login</button>
                        </div>
                    </form>
                    <div class="text-center mt-3">
                        <p class="mb-0">Don't have an account? <a href="#" data-bs-toggle="modal" data-bs-target="#registerModal" data-bs-dismiss="modal">Register here</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Admin Register Modal -->
    <div class="modal fade" id="adminRegisterModal" tabindex="-1" aria-labelledby="adminRegisterModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="adminRegisterModalLabel">Create Admin Account</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="AuthController" method="post">
                        <input type="hidden" name="action" value="register">
                        <input type="hidden" name="role" value="admin">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control" name="fullName" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Phone</label>
                                <input type="text" class="form-control" name="phone" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Username</label>
                                <input type="text" class="form-control" name="username" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Password</label>
                                <input type="password" class="form-control" name="password" required>
                            </div>
                            <div class="col-12 d-grid">
                                <button type="submit" class="btn btn-primary">Create Account</button>
                            </div>
                        </div>
                    </form>
                    <div class="text-center mt-3">
                        <p class="mb-0">Already have an account? <a href="#" data-bs-toggle="modal" data-bs-target="#adminLoginModal" data-bs-dismiss="modal">Login here</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Register Modal -->
    <div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="registerModalLabel">Create Customer Account</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="AuthController" method="post">
                        <input type="hidden" name="action" value="register">
                        <input type="hidden" name="role" value="customer">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control" name="fullName" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Phone</label>
                                <input type="text" class="form-control" name="phone" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Username</label>
                                <input type="text" class="form-control" name="username" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Password</label>
                                <input type="password" class="form-control" name="password" required>
                            </div>
                            <div class="col-12 d-grid">
                                <button type="submit" class="btn btn-primary">Create Account</button>
                            </div>
                        </div>
                    </form>
                    <div class="text-center mt-3">
                        <p class="mb-0">Already have an account? <a href="#" data-bs-toggle="modal" data-bs-target="#loginModal" data-bs-dismiss="modal">Login here</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Admin Add Vehicle Modal -->
    <c:if test="${not empty sessionScope.username && sessionScope.role == 'admin'}">
    <div class="modal fade" id="adminVehicleModal" tabindex="-1" aria-labelledby="adminVehicleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="adminVehicleModalLabel">
                        <i class="fas fa-plus-circle me-2"></i>Add New Vehicle
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="VehicleController" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="add">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label">
                                    <i class="fas fa-id-card me-1"></i>Vehicle ID
                                </label>
                                <input type="text" class="form-control" name="vehicleId" placeholder="Vehicle ID" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">
                                    <i class="fas fa-car me-1"></i>Vehicle Name
                                </label>
                                <input type="text" class="form-control" name="vehicleName" placeholder="Model/Name" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">
                                    <i class="fas fa-tags me-1"></i>Vehicle Type
                                </label>
                                <input type="text" class="form-control" name="vehicleType" placeholder="Type" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="fas fa-dollar-sign me-1"></i>Daily Price
                                </label>
                                <input type="number" class="form-control" name="dailyPrice" step="0.01" placeholder="Price per day" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="fas fa-toggle-on me-1"></i>Availability
                                </label>
                                <select class="form-select" name="available">
                                    <option value="true">Available</option>
                                    <option value="false">Unavailable</option>
                                </select>
                            </div>
                            <div class="col-12">
                                <label class="form-label">
                                    <i class="fas fa-image me-1"></i>Vehicle Image
                                </label>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <input type="file" class="form-control" name="vehicleImage" accept="image/*">
                                        <small class="text-muted">Upload image file</small>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="url" class="form-control" name="imageUrl" placeholder="Or enter image URL">
                                        <small class="text-muted">External image URL</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-save me-2"></i>Add Vehicle
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    </c:if>

    <!-- Admin Add Promotion Modal -->
    <c:if test="${not empty sessionScope.username && sessionScope.role == 'admin'}">
    <div class="modal fade" id="adminPromotionModal" tabindex="-1" aria-labelledby="adminPromotionModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="adminPromotionModalLabel">
                        <i class="fas fa-plus-circle me-2"></i>Add New Promotion
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="PromotionController" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="fas fa-tag me-1"></i>Title
                                </label>
                                <input type="text" class="form-control" name="title" placeholder="Promotion Title" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="fas fa-calendar-alt me-1"></i>Valid Until
                                </label>
                                <input type="date" class="form-control" name="validTill" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="fas fa-star me-1"></i>Badge Text
                                </label>
                                <input type="text" class="form-control" name="badge" placeholder="e.g., 20% OFF" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="fas fa-toggle-on me-1"></i>Status
                                </label>
                                <select class="form-select" name="active">
                                    <option value="true">Active</option>
                                    <option value="false">Inactive</option>
                                </select>
                            </div>
                            <div class="col-12">
                                <label class="form-label">
                                    <i class="fas fa-align-left me-1"></i>Description
                                </label>
                                <textarea class="form-control" name="description" rows="3" placeholder="Promotion description..." required></textarea>
                            </div>
                            <div class="col-12 d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-save me-2"></i>Create Promotion
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    </c:if>

    <!-- Customer Add Feedback Modal -->
    <div class="modal fade" id="customerFeedbackModal" tabindex="-1" aria-labelledby="customerFeedbackModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="customerFeedbackModalLabel">
                        <i class="fas fa-comments me-2"></i>Share Your Feedback
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="FeedbackController" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label">
                                    <i class="fas fa-star me-1"></i>Rating
                                </label>
                                <div class="rating-stars">
                                    <input type="radio" id="star5" name="rating" value="5" required>
                                    <label for="star5" title="5 stars"><i class="fas fa-star"></i></label>
                                    <input type="radio" id="star4" name="rating" value="4">
                                    <label for="star4" title="4 stars"><i class="fas fa-star"></i></label>
                                    <input type="radio" id="star3" name="rating" value="3">
                                    <label for="star3" title="3 stars"><i class="fas fa-star"></i></label>
                                    <input type="radio" id="star2" name="rating" value="2">
                                    <label for="star2" title="2 stars"><i class="fas fa-star"></i></label>
                                    <input type="radio" id="star1" name="rating" value="1">
                                    <label for="star1" title="1 star"><i class="fas fa-star"></i></label>
                                </div>
                            </div>
                            <div class="col-12">
                                <label class="form-label">
                                    <i class="fas fa-calendar-check me-1"></i>Related Booking (Optional)
                                </label>
                                <select class="form-select" name="bookingId">
                                    <option value="">Select a booking...</option>
                                    <c:forEach var="booking" items="${userBookings}">
                                        <option value="${booking.bookingId}">
                                            Booking #${booking.bookingId} - ${booking.vehicleName} (${booking.pickupDate})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-12">
                                <label class="form-label">
                                    <i class="fas fa-comment-alt me-1"></i>Your Feedback
                                </label>
                                <textarea class="form-control" name="comments" rows="4" placeholder="Tell us about your experience with CarGO..." required></textarea>
                            </div>
                            <div class="col-12 d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-paper-plane me-2"></i>Submit Feedback
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>