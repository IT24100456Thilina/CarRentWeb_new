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
            /* Professional Car Rental Color Palette */
            --primary-navy: #0A2540; /* Deep navy blue as specified */
            --primary-white: #ffffff;
            --accent-gold: #D4AF37; /* Gold accent color */
            --accent-orange: #FF8C00; /* Orange accent color */
            --text-dark: #1a1a1a;
            --text-light: #6b7280;
            --text-white: #ffffff;
            --bg-light: #f8fafc;
            --bg-gray: #e5e7eb;
            --border-light: #e5e7eb;

            /* Modern Gradients */
            --gradient-navy: linear-gradient(135deg, #0A2540 0%, #1e3a5f 100%);
            --gradient-gold: linear-gradient(135deg, #D4AF37 0%, #FFD700 100%);
            --gradient-orange: linear-gradient(135deg, #FF8C00 0%, #FFA500 100%);
            --gradient-hero: linear-gradient(135deg, rgba(10, 37, 64, 0.9) 0%, rgba(10, 37, 64, 0.7) 100%);

            /* Shadows */
            --shadow-sm: 0 1px 2px 0 rgba(10, 37, 64, 0.05);
            --shadow: 0 1px 3px 0 rgba(10, 37, 64, 0.1), 0 1px 2px 0 rgba(10, 37, 64, 0.06);
            --shadow-md: 0 4px 6px -1px rgba(10, 37, 64, 0.1), 0 2px 4px -1px rgba(10, 37, 64, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(10, 37, 64, 0.1), 0 4px 6px -2px rgba(10, 37, 64, 0.05);
            --shadow-xl: 0 20px 25px -5px rgba(10, 37, 64, 0.1), 0 10px 10px -5px rgba(10, 37, 64, 0.04);
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            font-size: 16px;
            line-height: 1.6;
            color: var(--text-dark);
            background: var(--primary-white);
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
            border-top: 4px solid var(--primary-orange);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Entrance Animations */
        .animate-on-scroll {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.8s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .animate-on-scroll.animate-in {
            opacity: 1;
            transform: translateY(0);
        }

        .animate-fade-in {
            opacity: 0;
            animation: fadeInUp 0.8s ease forwards;
        }

        .animate-slide-up {
            opacity: 0;
            transform: translateY(50px);
            animation: slideUp 0.8s ease forwards;
        }

        .animate-slide-left {
            opacity: 0;
            transform: translateX(-50px);
            animation: slideLeft 0.8s ease forwards;
        }

        .animate-slide-right {
            opacity: 0;
            transform: translateX(50px);
            animation: slideRight 0.8s ease forwards;
        }

        .animate-scale-in {
            opacity: 0;
            transform: scale(0.8);
            animation: scaleIn 0.6s ease forwards;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes scaleIn {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        /* Enhanced Modern Animations */
        .animate-bounce-in {
            opacity: 0;
            transform: scale(0.3);
            animation: bounceIn 0.8s cubic-bezier(0.68, -0.55, 0.265, 1.55) forwards;
        }

        .animate-flip-in {
            opacity: 0;
            transform: rotateY(-90deg);
            animation: flipIn 0.8s ease forwards;
        }

        .animate-glow {
            animation: glow 2s ease-in-out infinite alternate;
        }

        .animate-shimmer {
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            background-size: 200% 100%;
            animation: shimmer 2s infinite;
        }

        .animate-float-up {
            animation: floatUp 6s ease-in-out infinite;
        }

        .animate-pulse-slow {
            animation: pulseSlow 3s ease-in-out infinite;
        }

        .animate-rotate-slow {
            animation: rotateSlow 20s linear infinite;
        }

        /* Glass Morphism Effect */
        .glass-morphism {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-lg);
        }

        /* Ripple Effect */
        .ripple-effect {
            position: relative;
            overflow: hidden;
        }

        .ripple-effect::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .ripple-effect:active::before {
            width: 300px;
            height: 300px;
        }

        /* Parallax Elements */
        .parallax-element {
            transform: translateZ(0);
            will-change: transform;
        }

        /* Enhanced Keyframes */
        @keyframes bounceIn {
            0% {
                opacity: 0;
                transform: scale(0.3);
            }
            50% {
                opacity: 1;
                transform: scale(1.05);
            }
            70% {
                transform: scale(0.9);
            }
            100% {
                opacity: 1;
                transform: scale(1);
            }
        }

        @keyframes flipIn {
            from {
                opacity: 0;
                transform: rotateY(-90deg);
            }
            to {
                opacity: 1;
                transform: rotateY(0);
            }
        }

        @keyframes glow {
            from {
                box-shadow: 0 0 20px rgba(16, 185, 129, 0.3);
            }
            to {
                box-shadow: 0 0 40px rgba(16, 185, 129, 0.6);
            }
        }

        @keyframes shimmer {
            0% { background-position: -200% 0; }
            100% { background-position: 200% 0; }
        }

        @keyframes floatUp {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-10px) rotate(1deg); }
            66% { transform: translateY(-5px) rotate(-1deg); }
        }

        @keyframes pulseSlow {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }

        @keyframes rotateSlow {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        @keyframes countUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Staggered Animation Delays */
        .stagger-1 { animation-delay: 0.1s; }
        .stagger-2 { animation-delay: 0.2s; }
        .stagger-3 { animation-delay: 0.3s; }
        .stagger-4 { animation-delay: 0.4s; }
        .stagger-5 { animation-delay: 0.5s; }
        .stagger-6 { animation-delay: 0.6s; }

        /* Modern Header & Navigation */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            box-shadow: var(--shadow-sm);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            padding: 1rem 0;
            transition: all 0.3s ease;
        }

        .header.scrolled {
            padding: 0.75rem 0;
            background: rgba(255, 255, 255, 0.98);
            box-shadow: var(--shadow-md);
        }

        .navbar-brand {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--primary-navy) !important;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .navbar-brand .logo {
            width: 45px;
            height: 45px;
            background: var(--gradient-navy);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.4rem;
            font-weight: 700;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
        }

        .navbar-brand .logo::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transform: rotate(45deg);
            transition: all 0.6s ease;
            opacity: 0;
        }

        .navbar-brand .logo:hover::before {
            opacity: 1;
            animation: shimmer 1.5s ease-in-out;
        }

        .navbar-brand .logo:hover {
            transform: scale(1.1) rotate(5deg);
            box-shadow: var(--shadow-xl);
        }

        .navbar-nav .nav-link {
            font-weight: 500;
            color: var(--primary-navy) !important;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
            border-radius: 8px;
            margin: 0 0.25rem;
            position: relative;
            font-size: 1rem;
        }

        .navbar-nav .nav-link:hover {
            color: var(--accent-gold) !important;
            background: rgba(212, 175, 55, 0.1);
        }

        .btn-book-now {
            background: var(--gradient-gold);
            color: var(--primary-navy);
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            box-shadow: var(--shadow-md);
            margin-left: 1rem;
        }

        .btn-book-now:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            background: var(--gradient-orange);
            color: var(--primary-white);
        }

        /* Modern Hero Section */
        .hero {
            background: var(--gradient-hero);
            padding: 140px 0 100px;
            position: relative;
            min-height: 100vh;
            display: flex;
            align-items: center;
            color: white;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('https://images.unsplash.com/photo-1549317336-206569e8475c?w=1920&h=1080&fit=crop&crop=center');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            z-index: 0;
        }

        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(10, 37, 64, 0.7);
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
            font-weight: 800;
            color: white;
            line-height: 1.1;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            letter-spacing: -0.02em;
        }

        .hero-description {
            font-size: 1.25rem;
            color: rgba(255, 255, 255, 0.9);
            line-height: 1.6;
            margin-bottom: 2.5rem;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        .btn-primary-hero {
            background: var(--gradient-gold);
            color: var(--primary-navy);
            border: none;
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            box-shadow: var(--shadow-lg);
            margin: 0 0.5rem;
            position: relative;
            overflow: hidden;
        }

        .btn-primary-hero:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-xl);
            background: var(--gradient-orange);
            color: var(--primary-white);
        }

        .btn-secondary-hero {
            background: transparent;
            color: var(--primary-white);
            border: 2px solid var(--primary-white);
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin: 0 0.5rem;
        }

        .btn-secondary-hero:hover {
            background: var(--primary-white);
            color: var(--primary-navy);
            transform: translateY(-3px);
            box-shadow: var(--shadow-lg);
        }

        /* Booking Search Bar */
        .booking-search {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow-xl);
            margin-top: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .booking-search .form-label {
            color: var(--primary-navy);
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .booking-search .form-control,
        .booking-search .form-select {
            border: 2px solid var(--border-light);
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .booking-search .form-control:focus,
        .booking-search .form-select:focus {
            border-color: var(--accent-gold);
            box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.1);
        }

        .btn-search {
            background: var(--gradient-navy);
            color: var(--primary-white);
            border: none;
            padding: 1rem 2rem;
            border-radius: 12px;
            font-weight: 700;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-md);
        }

        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            background: var(--gradient-gold);
            color: var(--primary-navy);
        }

        .highlight-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 2.5rem;
            text-align: center;
            box-shadow: var(--shadow-xl);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: 1.5rem;
            opacity: 0;
            transform: translateY(30px) scale(0.9);
            animation: bounceIn 0.8s cubic-bezier(0.68, -0.55, 0.265, 1.55) forwards;
            position: relative;
            overflow: hidden;
        }

        .highlight-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
            border-radius: 20px;
            z-index: -1;
        }

        .highlight-card:nth-child(1) { animation-delay: 0.2s; }
        .highlight-card:nth-child(2) { animation-delay: 0.4s; }
        .highlight-card:nth-child(3) { animation-delay: 0.6s; }

        .highlight-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: var(--shadow-2xl);
            background: rgba(255, 255, 255, 0.15);
        }

        .highlight-card:hover .highlight-icon {
            transform: scale(1.1) rotate(5deg);
            animation: glow 1.5s ease-in-out infinite alternate;
        }

        .highlight-icon {
            width: 80px;
            height: 80px;
            background: var(--gradient-green);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-navy);
            font-size: 2rem;
            margin: 0 auto 1.5rem;
            box-shadow: var(--shadow-lg);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .highlight-icon::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transform: rotate(45deg);
            transition: all 0.6s ease;
            opacity: 0;
        }

        .highlight-icon:hover::before {
            opacity: 1;
            animation: shimmer 1.5s ease-in-out;
        }

        .highlight-content h3 {
            font-size: 2.25rem;
            font-weight: 800;
            color: var(--text-white);
            margin-bottom: 1rem;
        }

        .highlight-content p {
            color: rgba(255, 255, 255, 0.9);
            font-weight: 500;
            font-size: 1.1rem;
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

        /* Modern Sections */
        .section {
            padding: 80px 0;
            position: relative;
        }

        .section-title {
            font-size: clamp(2rem, 4vw, 3rem);
            font-weight: 800;
            color: var(--primary-navy);
            text-align: center;
            margin-bottom: 3rem;
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
            background: var(--gradient-gold);
            border-radius: 2px;
        }

        .section-subtitle {
            font-size: 1.2rem;
            color: var(--text-light);
            text-align: center;
            margin-bottom: 4rem;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Featured Vehicles Section */
        .featured-vehicles {
            background: var(--bg-light);
        }

        .vehicle-card {
            background: var(--primary-white);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-lg);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            height: 100%;
            border: 1px solid var(--border-light);
            position: relative;
        }

        .vehicle-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(212, 175, 55, 0.1) 0%, rgba(10, 37, 64, 0.05) 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
            border-radius: 20px;
            z-index: 1;
        }

        .vehicle-card:hover::before {
            opacity: 1;
        }

        .vehicle-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 40px rgba(10, 37, 64, 0.15), 0 10px 20px rgba(10, 37, 64, 0.1);
        }

        .vehicle-card:hover .vehicle-title {
            color: var(--accent-gold);
        }

        .vehicle-card:hover .btn-rent {
            background: var(--gradient-gold);
            color: var(--primary-navy);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .vehicle-image {
            position: relative;
            height: 250px;
            overflow: hidden;
        }

        .vehicle-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .vehicle-card:hover .vehicle-image img {
            transform: scale(1.1);
        }

        .vehicle-content {
            padding: 2rem;
        }

        .vehicle-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-navy);
            margin-bottom: 0.5rem;
        }

        .vehicle-subtitle {
            color: var(--text-light);
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .vehicle-price {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--accent-gold);
            margin-bottom: 1.5rem;
        }

        .btn-rent {
            background: var(--gradient-navy);
            color: var(--primary-white);
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            width: 100%;
            text-align: center;
        }

        .btn-rent:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
            background: var(--gradient-gold);
            color: var(--primary-navy);
        }

        /* Why Choose Us Section */
        .why-choose-us {
            background: var(--primary-white);
        }

        .feature-card {
            text-align: center;
            padding: 2rem;
            border-radius: 20px;
            transition: all 0.3s ease;
            height: 100%;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
            background: var(--bg-light);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            background: var(--gradient-navy);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-white);
            font-size: 2rem;
            margin: 0 auto 1.5rem;
            transition: all 0.3s ease;
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.1) rotate(5deg);
            background: var(--gradient-gold);
        }

        .feature-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-navy);
            margin-bottom: 1rem;
        }

        .feature-description {
            color: var(--text-light);
            line-height: 1.6;
        }

        .car-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-xl);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            height: 100%;
            opacity: 0;
            transform: translateY(30px) scale(0.9);
            animation: bounceIn 0.8s cubic-bezier(0.68, -0.55, 0.265, 1.55) forwards;
            position: relative;
        }

        .car-card:nth-child(1) { animation-delay: 0.1s; }
        .car-card:nth-child(2) { animation-delay: 0.2s; }
        .car-card:nth-child(3) { animation-delay: 0.3s; }
        .car-card:nth-child(4) { animation-delay: 0.4s; }
        .car-card:nth-child(5) { animation-delay: 0.5s; }
        .car-card:nth-child(6) { animation-delay: 0.6s; }

        .car-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.05) 0%, rgba(255, 255, 255, 0.02) 100%);
            border-radius: 20px;
            z-index: 0;
        }

        .car-card:hover {
            transform: translateY(-8px) scale(1.03);
            box-shadow: var(--shadow-2xl);
            background: rgba(255, 255, 255, 0.15);
        }

        .car-card .car-image {
            position: relative;
            z-index: 1;
        }

        .car-card .car-content {
            position: relative;
            z-index: 1;
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
            color: var(--accent-green);
        }

        .btn-rent {
            background: var(--gradient-green);
            color: var(--primary-navy);
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
            box-shadow: 0 8px 25px rgba(0, 255, 136, 0.3);
            color: var(--primary-navy);
        }

        .btn-view-all {
            background: transparent;
            color: var(--accent-green);
            border: 2px solid var(--accent-green);
            padding: 1rem 2rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-view-all:hover {
            background: var(--accent-green);
            color: var(--primary-navy);
            transform: translateY(-2px);
        }

        .car-card {
            position: relative;
            overflow: hidden;
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

        /* Ribbon styles for offers */
        .ribbon {
            position: absolute;
            top: 0;
            right: 0;
            z-index: 10;
            overflow: hidden;
            width: 75px;
            height: 75px;
            text-align: right;
        }

        .ribbon span {
            font-size: 10px;
            font-weight: bold;
            color: #FFF;
            text-transform: uppercase;
            text-align: center;
            line-height: 20px;
            transform: rotate(45deg);
            width: 100px;
            display: block;
            background: var(--accent-green);
            box-shadow: 0 0 10px rgba(0, 255, 136, 0.5);
            position: absolute;
            top: 19px;
            right: -21px;
        }

        .ribbon-top-right {
            top: -10px;
            right: -10px;
        }

        .ribbon-top-right::before,
        .ribbon-top-right::after {
            content: '';
            position: absolute;
            top: 0;
            border-top: 37px solid var(--accent-green);
            border-left: 37px solid transparent;
        }

        .ribbon-top-right::before {
            right: 0;
        }

        .ribbon-top-right::after {
            top: 37px;
            right: 37px;
            border-top: 0;
            border-right: 37px solid transparent;
            border-bottom: 37px solid var(--accent-green);
        }

        /* Price styling for discounts */
        .car-price .original {
            text-decoration: line-through;
            color: var(--text-light);
            font-size: 0.9rem;
            margin-right: 0.5rem;
        }

        .car-price .discounted {
            color: var(--accent-green);
            font-weight: 700;
        }

        /* Featured vehicle styling */
        .featured-vehicle {
            border: 2px solid var(--accent-green);
            box-shadow: 0 8px 25px rgba(0, 255, 136, 0.2);
        }

        .featured-vehicle .car-name {
            color: var(--accent-green);
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
            transform: translateZ(0);
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

        .btn:hover {
            transform: translateY(-2px) scale(1.02);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .btn:active {
            transform: translateY(0) scale(0.98);
            transition: all 0.1s ease;
        }

        /* Pulse Animation for CTAs */
        .btn-pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(0, 255, 136, 0.4);
            }
            70% {
                box-shadow: 0 0 0 10px rgba(0, 255, 136, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(0, 255, 136, 0);
            }
        }

        /* Floating Animation */
        .float-animation {
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        .btn-primary {
            background: var(--gradient-green);
            color: var(--primary-navy);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 255, 136, 0.3);
            color: var(--primary-navy);
        }

        .btn-outline-primary {
            border: 2px solid var(--accent-green);
            color: var(--accent-green);
            background: transparent;
        }

        .btn-outline-primary:hover {
            background: var(--accent-green);
            color: var(--primary-navy);
            transform: translateY(-2px);
        }

        /* Features Section */
        .features {
            background: var(--bg-gray);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            background: var(--gradient-green);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-navy);
            font-size: 2rem;
            margin: 0 auto 1.5rem;
            box-shadow: var(--shadow);
        }

        /* Stats Section */
        .stats {
            background: var(--primary-navy);
            color: var(--text-white);
        }

        .stat-item {
            text-align: center;
            padding: 2rem;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.8s ease forwards;
        }

        .stat-item:nth-child(1) { animation-delay: 0.1s; }
        .stat-item:nth-child(2) { animation-delay: 0.3s; }
        .stat-item:nth-child(3) { animation-delay: 0.5s; }
        .stat-item:nth-child(4) { animation-delay: 0.7s; }

        .stat-number {
            font-size: 3rem;
            font-weight: 800;
            color: var(--accent-green);
            display: block;
            transition: all 0.3s ease;
        }

        .stat-number:hover {
            transform: scale(1.1);
            color: var(--accent-green-light);
        }

        .stat-label {
            font-size: 1.125rem;
            opacity: 0.9;
            margin-top: 0.5rem;
        }

        /* Animated Counter */
        .counter {
            display: inline-block;
        }

        .counter[data-target] {
            position: relative;
        }

        .counter[data-target]::after {
            content: '+';
            position: absolute;
            right: -15px;
            top: 0;
            opacity: 0;
            animation: fadeIn 0.5s ease 2s forwards;
        }

        /* Modern Footer */
        .footer {
            background: var(--primary-navy);
            color: var(--primary-white);
            padding: 60px 0 30px;
        }

        .footer h5 {
            color: var(--primary-white);
            font-weight: 700;
            margin-bottom: 1.5rem;
        }

        .footer a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer a:hover {
            color: var(--accent-gold);
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
            background: var(--gradient-gold);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
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
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.8s ease forwards;
        }

        .contact-card:nth-child(1) { animation-delay: 0.1s; }
        .contact-card:nth-child(2) { animation-delay: 0.3s; }
        .contact-card:nth-child(3) { animation-delay: 0.5s; }

        .contact-card:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: var(--shadow-lg);
        }

        .contact-icon {
            width: 70px;
            height: 70px;
            background: var(--gradient-green);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-navy);
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

        /* Map Section Styling */
        .map-container {
            position: relative;
            border-radius: 20px;
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .map-overlay {
            animation: slideInLeft 0.8s ease forwards;
            opacity: 0;
            transform: translateX(-30px);
            animation-delay: 0.3s;
        }

        .map-legend {
            animation: slideInRight 0.8s ease forwards;
            opacity: 0;
            transform: translateX(30px);
            animation-delay: 0.5s;
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Enhanced Map Legend */
        .map-legend h6 {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.75rem;
        }

        .map-legend div {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        /* Map Responsive Design */
        @media (max-width: 768px) {
            .map-overlay {
                position: static;
                margin-bottom: 1rem;
                max-width: 100%;
            }

            .map-legend {
                position: static;
                margin-top: 1rem;
            }

            .map-container iframe {
                height: 350px !important;
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero {
                padding: 120px 0 80px;
                min-height: 80vh;
            }

            .hero-title {
                font-size: clamp(2.5rem, 8vw, 4rem);
                margin-bottom: 1.5rem;
            }

            .hero-description {
                font-size: 1.1rem;
                margin-bottom: 2rem;
            }

            .btn-primary-hero, .btn-secondary-hero {
                padding: 1rem 2rem;
                font-size: 1rem;
                margin: 0.5rem;
                width: auto;
                display: inline-block;
            }

            .booking-search {
                padding: 1.5rem;
                margin-top: 1.5rem;
            }

            .section {
                padding: 60px 0;
            }

            .section-title {
                font-size: clamp(1.8rem, 5vw, 2.5rem);
                margin-bottom: 2rem;
            }

            .navbar-brand {
                font-size: 1.5rem;
            }

            .navbar-brand .logo {
                width: 40px;
                height: 40px;
                font-size: 1.2rem;
            }

            .btn-book-now {
                margin-left: 0.5rem;
                padding: 0.6rem 1.2rem;
                font-size: 0.9rem;
            }

            .vehicle-card {
                margin-bottom: 2rem;
            }

            .feature-icon {
                width: 70px;
                height: 70px;
                font-size: 1.8rem;
            }

            .footer {
                padding: 40px 0 20px;
            }
        }

        @media (max-width: 576px) {
            .hero {
                padding: 100px 0 60px;
                min-height: 70vh;
            }

            .hero-title {
                font-size: clamp(2rem, 8vw, 3rem);
            }

            .hero-description {
                font-size: 1rem;
            }

            .btn-primary-hero, .btn-secondary-hero {
                padding: 0.875rem 1.75rem;
                font-size: 0.95rem;
                margin: 0.25rem;
            }

            .booking-search {
                padding: 1rem;
            }

            .vehicle-content {
                padding: 1.5rem;
            }

            .vehicle-title {
                font-size: 1.3rem;
            }

            .feature-icon {
                width: 60px;
                height: 60px;
                font-size: 1.5rem;
            }

            .footer {
                text-align: center;
            }
        }

        @media (max-width: 576px) {
            .hero {
                padding: 100px 0 60px;
                min-height: 70vh;
            }

            .hero-content {
                margin-bottom: 2rem;
            }

            .hero-title {
                font-size: clamp(2rem, 8vw, 3.5rem);
            }

            .hero-description {
                font-size: 1rem;
            }

            .btn-get-started, .btn-outline-started {
                padding: 0.875rem 1.75rem;
                font-size: 0.95rem;
                margin: 0.25rem;
            }

            .highlight-card {
                padding: 1.25rem;
            }

            .car-content {
                padding: 1rem;
            }

            .car-name {
                font-size: 1.1rem;
            }

            .btn-rent {
                padding: 0.6rem 1.2rem;
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

            .service-icon, .feature-icon {
                width: 60px;
                height: 60px;
                font-size: 1.5rem;
            }

            .process-step .step-number {
                width: 60px;
                height: 60px;
                font-size: 1.5rem;
            }

            .testimonial-slider .card-body {
                padding: 1.5rem 1rem;
            }

            .cta-banner h2 {
                font-size: 1.75rem !important;
            }

            .cta-banner p {
                font-size: 1rem !important;
            }

            .promo-banner {
                font-size: 0.8rem;
                padding: 8px 0;
            }

            .newsletter-section h4 {
                font-size: 1.25rem;
            }
        }

        /* Tablet adjustments */
        @media (min-width: 769px) and (max-width: 992px) {
            .hero-title {
                font-size: clamp(3rem, 6vw, 4.5rem);
            }

            .section {
                padding: 80px 0;
            }

            .service-icon, .feature-icon {
                width: 75px;
                height: 75px;
                font-size: 1.9rem;
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

        /* Chatbot Styles */
        .chatbot-widget {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1050;
            font-family: 'Poppins', sans-serif;
        }

        .chatbot-toggle {
            width: 60px;
            height: 60px;
            background: var(--gradient-green);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-navy);
            font-size: 1.5rem;
            cursor: pointer;
            box-shadow: 0 4px 20px rgba(0, 255, 136, 0.4);
            transition: all 0.3s ease;
            border: none;
        }

        .chatbot-toggle:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 25px rgba(0, 255, 136, 0.5);
        }

        .chatbot-window {
            position: absolute;
            bottom: 80px;
            right: 0;
            width: 350px;
            height: 500px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
            display: none;
            flex-direction: column;
            overflow: hidden;
            animation: slideUp 0.3s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .chatbot-header {
            background: var(--gradient-green);
            color: var(--primary-navy);
            padding: 1rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .chatbot-avatar {
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .chatbot-info h5 {
            margin: 0;
            font-size: 1rem;
            font-weight: 600;
        }

        .chatbot-info span {
            font-size: 0.8rem;
            opacity: 0.8;
        }

        .chatbot-close {
            margin-left: auto;
            background: none;
            border: none;
            color: white;
            font-size: 1.2rem;
            cursor: pointer;
            padding: 0.25rem;
            border-radius: 50%;
            transition: background 0.3s ease;
        }

        .chatbot-close:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .chatbot-messages {
            flex: 1;
            padding: 1rem;
            overflow-y: auto;
            background: #f8f9fa;
        }

        .message {
            margin-bottom: 1rem;
            display: flex;
            flex-direction: column;
        }

        .message-content {
            padding: 0.75rem 1rem;
            border-radius: 18px;
            max-width: 80%;
            word-wrap: break-word;
            font-size: 0.9rem;
            line-height: 1.4;
        }

        .bot-message .message-content {
            background: white;
            color: var(--text-dark);
            align-self: flex-start;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .user-message {
            align-items: flex-end;
        }

        .user-message .message-content {
            background: var(--accent-green);
            color: var(--primary-navy);
            align-self: flex-end;
        }

        .message-time {
            font-size: 0.7rem;
            color: #666;
            margin-top: 0.25rem;
            padding: 0 0.5rem;
        }

        .bot-message .message-time {
            align-self: flex-start;
        }

        .user-message .message-time {
            align-self: flex-end;
        }

        .chatbot-input {
            padding: 1rem;
            background: white;
            border-top: 1px solid #e0e0e0;
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .chatbot-input input {
            flex: 1;
            padding: 0.75rem 1rem;
            border: 2px solid #e0e0e0;
            border-radius: 25px;
            outline: none;
            font-size: 0.9rem;
            transition: border-color 0.3s ease;
        }

        .chatbot-input input:focus {
            border-color: var(--accent-green);
        }

        .chatbot-input button {
            width: 40px;
            height: 40px;
            background: var(--gradient-green);
            border: none;
            border-radius: 50%;
            color: var(--primary-navy);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .chatbot-input button:hover {
            transform: scale(1.1);
            box-shadow: 0 4px 15px rgba(0, 255, 136, 0.3);
        }

        /* Mobile responsiveness */
        @media (max-width: 576px) {
            .chatbot-widget {
                bottom: 15px;
                right: 15px;
            }

            .chatbot-window {
                width: calc(100vw - 30px);
                height: 400px;
                bottom: 85px;
            }

            .chatbot-toggle {
                width: 50px;
                height: 50px;
                font-size: 1.2rem;
            }
        }

        /* Typing indicator */
        .typing-indicator {
            display: flex;
            gap: 0.25rem;
            padding: 0.75rem 1rem;
            align-self: flex-start;
        }

        .typing-indicator span {
            width: 8px;
            height: 8px;
            background: #666;
            border-radius: 50%;
            animation: typing 1.4s infinite;
        }

        .typing-indicator span:nth-child(2) {
            animation-delay: 0.2s;
        }

        .typing-indicator span:nth-child(3) {
            animation-delay: 0.4s;
        }

        @keyframes typing {
            0%, 60%, 100% {
                transform: translateY(0);
                opacity: 0.4;
            }
            30% {
                transform: translateY(-10px);
                opacity: 1;
            }
        }

        /* Form Input Animations */
        .form-control {
            transition: all 0.3s ease;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
        }

        .form-control:focus {
            border-color: var(--accent-green);
            box-shadow: 0 0 0 3px rgba(0, 255, 136, 0.1);
            transform: translateY(-1px);
        }

        .form-select:focus {
            border-color: var(--accent-green);
            box-shadow: 0 0 0 3px rgba(0, 255, 136, 0.1);
            transform: translateY(-1px);
        }

        /* Modal Animations */
        .modal.fade .modal-dialog {
            transform: translate(0, -50px);
            transition: transform 0.3s ease-out;
        }

        .modal.show .modal-dialog {
            transform: translate(0, 0);
        }

        /* Hover Effects for Interactive Elements */
        .nav-link {
            position: relative;
            overflow: hidden;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: -100%;
            width: 100%;
            height: 2px;
            background: var(--accent-green);
            transition: left 0.3s ease;
        }

        .nav-link:hover::after {
            left: 0;
        }

        /* Card hover effects with micro-interactions */
        .card {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .card:hover {
            transform: translateY(-2px);
        }

        /* Image zoom effects */
        .gallery-item img,
        .car-image img {
            transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .gallery-item:hover img,
        .car-card:hover .car-image img {
            transform: scale(1.1);
        }

        /* Loading states */
        .btn.loading {
            position: relative;
            color: transparent !important;
        }

        .btn.loading::after {
            content: '';
            position: absolute;
            width: 16px;
            height: 16px;
            top: 50%;
            left: 50%;
            margin-left: -8px;
            margin-top: -8px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        /* Success/Error animations */
        @keyframes successPulse {
            0% { box-shadow: 0 0 0 0 rgba(0, 255, 136, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(0, 255, 136, 0); }
            100% { box-shadow: 0 0 0 0 rgba(0, 255, 136, 0); }
        }

        @keyframes errorShake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }

        .success-animation {
            animation: successPulse 0.6s ease-out;
        }

        .error-animation {
            animation: errorShake 0.5s ease-in-out;
        }

        /* Performance optimizations */
        .animate-on-scroll,
        .car-card,
        .highlight-card,
        .contact-card,
        .stat-item {
            will-change: transform, opacity;
        }

        /* Category and Brand Card Styles */
        .category-card:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: var(--shadow-xl);
            background: rgba(255, 255, 255, 0.15);
        }

        .brand-card:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: var(--shadow-lg);
            background: var(--gradient-gold);
            color: var(--primary-navy);
        }

        .brand-card:hover h6,
        .brand-card:hover small {
            color: var(--primary-navy);
        }

        /* Blog Card Styles */
        .blog-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: var(--shadow-xl);
            background: rgba(255, 255, 255, 0.15);
        }

        .blog-card:hover .blog-image img {
            transform: scale(1.1);
        }

        .blog-card:hover .blog-read-more {
            color: var(--primary-navy);
            transform: translateX(5px);
        }

        .newsletter-card {
            position: relative;
            overflow: hidden;
        }

        .newsletter-form .form-control:focus {
            box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.3);
            border-color: var(--accent-gold);
        }

        .newsletter-form .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        /* Service Type Toggle Styles */
        .service-type-toggle .btn-check:checked + .btn {
            background: var(--gradient-navy) !important;
            color: white !important;
            border-color: var(--gradient-navy) !important;
        }

        .service-fields {
            animation: fadeInUp 0.5s ease;
        }

        .btn-check + .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* CTA Banner Styles */
        .cta-pattern-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="cta-pattern" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="20" cy="20" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="80" cy="80" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="50" cy="10" r="1" fill="rgba(255,255,255,0.05)"/><circle cx="10" cy="90" r="1" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100" height="100" fill="url(%23cta-pattern)"/></svg>');
            opacity: 0.5;
        }

        .cta-banner-section {
            position: relative;
        }

        .cta-stat {
            text-align: center;
        }

        .btn-cta-primary:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: var(--shadow-xl);
            background: var(--gradient-orange);
            color: var(--primary-white);
        }

        .btn-cta-secondary:hover {
            background: var(--accent-gold);
            color: var(--primary-navy);
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        /* Premium Animation Enhancements */
        .premium-glow {
            animation: premiumGlow 3s ease-in-out infinite alternate;
        }

        @keyframes premiumGlow {
            from {
                box-shadow: 0 0 20px rgba(212, 175, 55, 0.3);
            }
            to {
                box-shadow: 0 0 40px rgba(212, 175, 55, 0.6), 0 0 60px rgba(212, 175, 55, 0.3);
            }
        }

        .text-shimmer {
            background: linear-gradient(90deg, var(--primary-navy) 25%, var(--accent-gold) 50%, var(--primary-navy) 75%);
            background-size: 200% 100%;
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: shimmer 3s infinite;
        }

        .floating-elements {
            animation: floatingElements 6s ease-in-out infinite;
        }

        @keyframes floatingElements {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-10px) rotate(1deg); }
            66% { transform: translateY(-5px) rotate(-1deg); }
        }

        /* Enhanced Glass Morphism */
        .glass-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px rgba(10, 37, 64, 0.1);
        }

        /* Premium Button Effects */
        .btn-premium {
            position: relative;
            overflow: hidden;
            background: linear-gradient(45deg, var(--gradient-navy), var(--gradient-gold));
            background-size: 200% 200%;
            animation: gradientShift 3s ease infinite;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Enhanced Mobile Responsive Design */
        @media (max-width: 768px) {
            /* Improved mobile sections */
            .section {
                padding: 50px 0;
            }

            .section-title {
                font-size: clamp(1.8rem, 5vw, 2.5rem);
                margin-bottom: 2rem;
            }

            .section-subtitle {
                font-size: 1rem;
                margin-bottom: 3rem;
            }

            /* Mobile category cards */
            .category-card {
                padding: 1.5rem;
                margin-bottom: 1rem;
            }

            .category-card h5 {
                font-size: 1.3rem;
            }

            /* Mobile brand cards */
            .brand-card {
                padding: 1rem;
                margin-bottom: 1rem;
            }

            /* Mobile blog cards */
            .blog-card .blog-content {
                padding: 1.5rem;
            }

            .blog-card .blog-image {
                height: 200px;
            }

            /* Mobile CTA stats */
            .cta-stats {
                justify-content: center;
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .cta-stat {
                text-align: center;
            }

            .cta-stat .stat-number {
                font-size: 1.5rem;
            }

            /* Mobile buttons */
            .btn-cta-primary,
            .btn-cta-secondary {
                width: 100%;
                margin-bottom: 0.5rem;
            }

            /* Mobile service toggle */
            .service-type-toggle .btn {
                padding: 0.6rem 1rem;
                font-size: 0.9rem;
            }

            /* Mobile newsletter */
            .newsletter-card {
                padding: 2rem 1.5rem;
            }

            .newsletter-form .input-group {
                flex-direction: column;
            }

            .newsletter-form .form-control {
                border-radius: 25px;
                margin-bottom: 1rem;
            }

            .newsletter-form .btn {
                border-radius: 25px;
            }
        }

        @media (max-width: 576px) {
            /* Extra small mobile devices */
            .hero {
                padding: 80px 0 40px;
                min-height: 60vh;
            }

            .hero-title {
                font-size: clamp(1.8rem, 6vw, 2.5rem);
            }

            .hero-description {
                font-size: 0.95rem;
            }

            .booking-search {
                padding: 1rem;
            }

            .highlight-card {
                padding: 1rem;
                margin-bottom: 1rem;
            }

            .feature-card {
                padding: 1.5rem;
                margin-bottom: 1.5rem;
            }

            .vehicle-card {
                margin-bottom: 1.5rem;
            }

            .contact-card {
                padding: 1rem;
                margin-bottom: 1rem;
            }

            /* Mobile footer */
            .footer {
                padding: 30px 0 20px;
            }

            .footer h5 {
                margin-top: 1.5rem;
                margin-bottom: 1rem;
            }

            .social-links {
                text-align: center;
                margin-top: 1rem;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .vehicle-card:hover,
            .category-card:hover,
            .brand-card:hover,
            .blog-card:hover {
                transform: none;
                box-shadow: var(--shadow);
            }

            .btn:hover {
                transform: none;
            }
        }

        /* High DPI display optimizations */
        @media (-webkit-min-device-pixel-ratio: 2), (min-resolution: 192dpi) {
            .vehicle-image img,
            .blog-image img {
                image-rendering: -webkit-optimize-contrast;
                image-rendering: crisp-edges;
            }
        }

        /* Performance optimizations for smooth animations */
        .vehicle-card,
        .category-card,
        .brand-card,
        .blog-card,
        .btn {
            will-change: transform;
        }

        /* Ensure smooth scrolling */
        html {
            scroll-behavior: smooth;
        }

        /* Optimize for reduced motion preference */
        @media (prefers-reduced-motion: reduce) {
            * {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
                scroll-behavior: auto !important;
            }
        }

        /* Reduce motion for accessibility */
        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
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
                        <li class="nav-item"><a class="nav-link" href="#featured-vehicles">Vehicles</a></li>
                        <li class="nav-item"><a class="nav-link" href="#why-choose-us">Why Choose Us</a></li>
                        <li class="nav-item"><a class="nav-link" href="#location">Location</a></li>
                        <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
                    </ul>
                    <ul class="navbar-nav ms-auto align-items-center">
                        <c:if test="${not empty sessionScope.username && sessionScope.role == 'admin'}">
                            <li class="nav-item"><a class="btn-book-now me-2" data-bs-toggle="modal" data-bs-target="#adminVehicleModal"><i class="fas fa-plus me-1"></i>Add Vehicle</a></li>
                            <li class="nav-item"><a class="btn-book-now me-2" data-bs-toggle="modal" data-bs-target="#adminPromotionModal"><i class="fas fa-tag me-1"></i>Add Promotion</a></li>
                        </c:if>
                        <c:if test="${empty sessionScope.username}">
                            <li class="nav-item"><a class="btn-book-now me-2" data-bs-toggle="modal" data-bs-target="#adminLoginModal">Admin Login</a></li>
                            <li class="nav-item"><a class="btn-book-now me-2" data-bs-toggle="modal" data-bs-target="#adminRegisterModal">Admin Register</a></li>
                            <li class="nav-item"><a class="btn-book-now" data-bs-toggle="modal" data-bs-target="#registerModal">Sign Up</a></li>
                        </c:if>
                        <c:if test="${not empty sessionScope.username}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    ${sessionScope.userFullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><span class="dropdown-item-text text-muted">Role: ${sessionScope.role}</span></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <c:if test="${sessionScope.role == 'customer'}">
                                        <li><a class="dropdown-item" href="HomeServlet?page=customer-booking">My Bookings</a></li>
                                        <li><a class="dropdown-item" href="HomeServlet?page=customer-feedback">Feedback</a></li>
                                    </c:if>
                                    <c:if test="${sessionScope.role == 'admin'}">
                                        <li><a class="dropdown-item" href="AdminServlet">Admin Dashboard</a></li>
                                        <li><a class="dropdown-item" href="AdminBoardController">Admin Board</a></li>
                                    </c:if>
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
                        <div class="d-flex gap-3 flex-wrap justify-content-center">
                            <a href="#featured-vehicles" class="btn-primary-hero">Browse Vehicles</a>
                            <a href="<c:choose><c:when test="${sessionScope.role == 'admin'}">AdminServlet</c:when><c:otherwise>HomeServlet?page=customer-dashboard</c:otherwise></c:choose>" class="btn-secondary-hero">My Dashboard</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <h1 class="hero-title">Rent Your Dream Car — Anytime, Anywhere</h1>
                        <p class="hero-description">Affordable, reliable, and premium car rental services at your fingertips.</p>
                        <div class="d-flex gap-3 flex-wrap justify-content-center">
                            <a href="#featured-vehicles" class="btn-primary-hero">Explore Fleet</a>
                            <a data-bs-toggle="modal" data-bs-target="#loginModal" class="btn-secondary-hero">Sign In</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Enhanced Search Bar -->
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="booking-search">
                        <!-- Service Type Toggle -->
                        <div class="service-type-toggle" style="text-align: center; margin-bottom: 2rem;">
                            <div class="btn-group" role="group" aria-label="Service type">
                                <input type="radio" class="btn-check" name="serviceType" id="rentalService" value="rental" checked>
                                <label class="btn" for="rentalService" style="
                                    background: var(--gradient-navy);
                                    color: white;
                                    border: none;
                                    border-radius: 25px 0 0 25px;
                                    padding: 0.75rem 1.5rem;
                                    font-weight: 600;
                                    transition: all 0.3s ease;">
                                    <i class="fas fa-key me-2"></i>Car Rental
                                </label>
                                <input type="radio" class="btn-check" name="serviceType" id="salesService" value="sales">
                                <label class="btn" for="salesService" style="
                                    background: transparent;
                                    color: var(--primary-navy);
                                    border: 2px solid var(--accent-gold);
                                    border-radius: 0 25px 25px 0;
                                    padding: 0.75rem 1.5rem;
                                    font-weight: 600;
                                    transition: all 0.3s ease;">
                                    <i class="fas fa-shopping-cart me-2"></i>Vehicle Sales
                                </label>
                            </div>
                        </div>

                        <!-- Rental Service Fields -->
                        <div id="rentalFields" class="service-fields">
                            <form class="row g-3">
                                <div class="col-md-3">
                                    <label class="form-label">
                                        <i class="fas fa-map-marker-alt me-2"></i>Pickup Location
                                    </label>
                                    <select class="form-select">
                                        <option selected>Colombo</option>
                                        <option>Kandy</option>
                                        <option>Galle</option>
                                        <option>Jaffna</option>
                                        <option>Negombo</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">
                                        <i class="fas fa-calendar-alt me-2"></i>Pickup Date
                                    </label>
                                    <input type="date" class="form-control">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">
                                        <i class="fas fa-calendar-check me-2"></i>Return Date
                                    </label>
                                    <input type="date" class="form-control">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">
                                        <i class="fas fa-car me-2"></i>Vehicle Type
                                    </label>
                                    <select class="form-select">
                                        <option selected>All Types</option>
                                        <option>Economy</option>
                                        <option>Luxury</option>
                                        <option>SUV</option>
                                        <option>Van</option>
                                    </select>
                                </div>
                                <div class="col-12 text-center">
                                    <button type="submit" class="btn-search">
                                        <i class="fas fa-search me-2"></i>Search Available Vehicles
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Sales Service Fields -->
                        <div id="salesFields" class="service-fields" style="display: none;">
                            <form class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label">
                                        <i class="fas fa-map-marker-alt me-2"></i>Location
                                    </label>
                                    <select class="form-select">
                                        <option selected>Colombo</option>
                                        <option>Kandy</option>
                                        <option>Galle</option>
                                        <option>Jaffna</option>
                                        <option>Negombo</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">
                                        <i class="fas fa-tag me-2"></i>Condition
                                    </label>
                                    <select class="form-select">
                                        <option selected>All Conditions</option>
                                        <option>New</option>
                                        <option>Used</option>
                                        <option>Certified Pre-Owned</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">
                                        <i class="fas fa-car me-2"></i>Vehicle Type
                                    </label>
                                    <select class="form-select">
                                        <option selected>All Types</option>
                                        <option>Sedan</option>
                                        <option>SUV</option>
                                        <option>Hatchback</option>
                                        <option>Van</option>
                                    </select>
                                </div>
                                <div class="col-12 text-center">
                                    <button type="submit" class="btn-search">
                                        <i class="fas fa-shopping-cart me-2"></i>Browse Vehicles for Sale
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-md-4">
                    <div class="highlight-card">
                        <div class="highlight-icon">
                            <i class="fas fa-car"></i>
                        </div>
                        <div class="highlight-content">
                            <h3>50+ Premium Vehicles</h3>
                            <p>Curated selection for every journey</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="highlight-card">
                        <div class="highlight-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <div class="highlight-content">
                            <h3>Trusted by 10K+ Customers</h3>
                            <p>Excellence in service since 2020</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="highlight-card">
                        <div class="highlight-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="highlight-content">
                            <h3>Instant Booking</h3>
                            <p>Reserve in seconds, drive immediately</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Why Choose Us Section -->
    <section class="section why-choose-us" id="why-choose-us">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title">Why Choose CarGO?</h2>
                <p class="section-subtitle">Experience the difference with our premium services and customer-first approach</p>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-car"></i>
                        </div>
                        <h5 class="feature-title">Wide Selection of Vehicles</h5>
                        <p class="feature-description">From economy cars to luxury vehicles, we have the perfect ride for every occasion and budget.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <h5 class="feature-title">Affordable Rates</h5>
                        <p class="feature-description">Competitive pricing with no hidden fees. Get the best value for your money with transparent pricing.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h5 class="feature-title">24/7 Customer Support</h5>
                        <p class="feature-description">Our dedicated support team is available round the clock to assist you whenever you need help.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h5 class="feature-title">Easy Online Booking</h5>
                        <p class="feature-description">Simple, secure, and fast booking process. Reserve your vehicle in minutes from anywhere.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Browse by Category Section -->
    <section class="section" id="browse-categories" style="background: var(--bg-white);">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title">Browse by Category</h2>
                <p class="section-subtitle">Find your perfect vehicle by type or brand</p>
            </div>

            <!-- Vehicle Types -->
            <div class="row g-4 mb-5">
                <div class="col-12">
                    <h4 class="mb-4" style="color: var(--primary-navy); font-weight: 700;">
                        <i class="fas fa-car me-2"></i>Vehicle Types
                    </h4>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="category-card" style="
                        background: var(--glass-bg);
                        backdrop-filter: blur(20px);
                        border: 1px solid var(--glass-border);
                        border-radius: 20px;
                        padding: 2rem;
                        text-align: center;
                        transition: all 0.3s ease;
                        cursor: pointer;
                        height: 100%;
                        position: relative;
                        overflow: hidden;">
                        <div style="width: 80px; height: 80px; background: var(--gradient-navy); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; font-size: 2rem; color: white; transition: all 0.3s ease;">
                            <i class="fas fa-car"></i>
                        </div>
                        <h5 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem;">Sedan</h5>
                        <p style="color: var(--text-light); margin-bottom: 1.5rem;">Comfortable and efficient for city driving</p>
                        <div style="color: var(--accent-gold); font-weight: 700; font-size: 1.5rem; margin-bottom: 1rem;">15+ Available</div>
                        <a href="#featured-vehicles" onclick="filterByType('Sedan')" class="btn" style="background: var(--gradient-navy); color: white; border: none; border-radius: 25px; padding: 0.75rem 1.5rem; font-size: 0.9rem; text-decoration: none;">
                            View Sedans <i class="fas fa-arrow-right ms-2"></i>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="category-card" style="
                        background: var(--glass-bg);
                        backdrop-filter: blur(20px);
                        border: 1px solid var(--glass-border);
                        border-radius: 20px;
                        padding: 2rem;
                        text-align: center;
                        transition: all 0.3s ease;
                        cursor: pointer;
                        height: 100%;
                        position: relative;
                        overflow: hidden;">
                        <div style="width: 80px; height: 80px; background: var(--gradient-navy); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; font-size: 2rem; color: white; transition: all 0.3s ease;">
                            <i class="fas fa-truck-monster"></i>
                        </div>
                        <h5 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem;">SUV</h5>
                        <p style="color: var(--text-light); margin-bottom: 1.5rem;">Perfect for family trips and adventures</p>
                        <div style="color: var(--accent-gold); font-weight: 700; font-size: 1.5rem; margin-bottom: 1rem;">20+ Available</div>
                        <a href="#featured-vehicles" onclick="filterByType('SUV')" class="btn" style="background: var(--gradient-navy); color: white; border: none; border-radius: 25px; padding: 0.75rem 1.5rem; font-size: 0.9rem; text-decoration: none;">
                            View SUVs <i class="fas fa-arrow-right ms-2"></i>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="category-card" style="
                        background: var(--glass-bg);
                        backdrop-filter: blur(20px);
                        border: 1px solid var(--glass-border);
                        border-radius: 20px;
                        padding: 2rem;
                        text-align: center;
                        transition: all 0.3s ease;
                        cursor: pointer;
                        height: 100%;
                        position: relative;
                        overflow: hidden;">
                        <div style="width: 80px; height: 80px; background: var(--gradient-navy); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; font-size: 2rem; color: white; transition: all 0.3s ease;">
                            <i class="fas fa-shuttle-van"></i>
                        </div>
                        <h5 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem;">Van</h5>
                        <p style="color: var(--text-light); margin-bottom: 1.5rem;">Spacious for group travel and cargo</p>
                        <div style="color: var(--accent-gold); font-weight: 700; font-size: 1.5rem; margin-bottom: 1rem;">8+ Available</div>
                        <a href="#featured-vehicles" onclick="filterByType('Van')" class="btn" style="background: var(--gradient-navy); color: white; border: none; border-radius: 25px; padding: 0.75rem 1.5rem; font-size: 0.9rem; text-decoration: none;">
                            View Vans <i class="fas fa-arrow-right ms-2"></i>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="category-card" style="
                        background: var(--glass-bg);
                        backdrop-filter: blur(20px);
                        border: 1px solid var(--glass-border);
                        border-radius: 20px;
                        padding: 2rem;
                        text-align: center;
                        transition: all 0.3s ease;
                        cursor: pointer;
                        height: 100%;
                        position: relative;
                        overflow: hidden;">
                        <div style="width: 80px; height: 80px; background: var(--gradient-navy); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; font-size: 2rem; color: white; transition: all 0.3s ease;">
                            <i class="fas fa-leaf"></i>
                        </div>
                        <h5 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem;">Hybrid/Electric</h5>
                        <p style="color: var(--text-light); margin-bottom: 1.5rem;">Eco-friendly options for sustainable travel</p>
                        <div style="color: var(--accent-gold); font-weight: 700; font-size: 1.5rem; margin-bottom: 1rem;">5+ Available</div>
                        <a href="#featured-vehicles" onclick="filterByType('Hybrid')" class="btn" style="background: var(--gradient-navy); color: white; border: none; border-radius: 25px; padding: 0.75rem 1.5rem; font-size: 0.9rem; text-decoration: none;">
                            View Hybrids <i class="fas fa-arrow-right ms-2"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Popular Brands -->
            <div class="row g-4">
                <div class="col-12">
                    <h4 class="mb-4" style="color: var(--primary-navy); font-weight: 700;">
                        <i class="fas fa-star me-2"></i>Popular Brands
                    </h4>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6">
                    <div class="brand-card" onclick="filterByBrand('Toyota')" style="
                        background: var(--glass-bg);
                        backdrop-filter: blur(20px);
                        border: 1px solid var(--glass-border);
                        border-radius: 15px;
                        padding: 1.5rem;
                        text-align: center;
                        transition: all 0.3s ease;
                        cursor: pointer;
                        position: relative;
                        overflow: hidden;">
                        <div style="width: 60px; height: 60px; background: var(--gradient-gold); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; font-weight: 700; color: var(--primary-navy); font-size: 1.5rem;">
                            T
                        </div>
                        <h6 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 0.5rem;">Toyota</h6>
                        <small style="color: var(--text-light);">12 vehicles</small>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6">
                    <div class="brand-card" onclick="filterByBrand('Honda')" style="
                        background: var(--glass-bg);
                        backdrop-filter: blur(20px);
                        border: 1px solid var(--glass-border);
                        border-radius: 15px;
                        padding: 1.5rem;
                        text-align: center;
                        transition: all 0.3s ease;
                        cursor: pointer;
                        position: relative;
                        overflow: hidden;">
                        <div style="width: 60px; height: 60px; background: var(--gradient-gold); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; font-weight: 700; color: var(--primary-navy); font-size: 1.5rem;">
                            H
                        </div>
                        <h6 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 0.5rem;">Honda</h6>
                        <small style="color: var(--text-light);">8 vehicles</small>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6">
                    <div class="brand-card" onclick="filterByBrand('BMW')" style="
                        background: var(--glass-bg);
                        backdrop-filter: blur(20px);
                        border: 1px solid var(--glass-border);
                        border-radius: 15px;
                        padding: 1.5rem;
                        text-align: center;
                        transition: all 0.3s ease;
                        cursor: pointer;
                        position: relative;
                        overflow: hidden;">
                        <div style="width: 60px; height: 60px; background: var(--gradient-gold); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; font-weight: 700; color: var(--primary-navy); font-size: 1.5rem;">
                            BMW
                        </div>
                        <h6 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 0.5rem;">BMW</h6>
                        <small style="color: var(--text-light);">6 vehicles</small>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6">
                    <div class="brand-card" onclick="filterByBrand('Audi')" style="
                        background: var(--glass-bg);
                        backdrop-filter: blur(20px);
                        border: 1px solid var(--glass-border);
                        border-radius: 15px;
                        padding: 1.5rem;
                        text-align: center;
                        transition: all 0.3s ease;
                        cursor: pointer;
                        position: relative;
                        overflow: hidden;">
                        <div style="width: 60px; height: 60px; background: var(--gradient-gold); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; font-weight: 700; color: var(--primary-navy); font-size: 1.5rem;">
                            A
                        </div>
                        <h6 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 0.5rem;">Audi</h6>
                        <small style="color: var(--text-light);">4 vehicles</small>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6">
                    <div class="brand-card" onclick="filterByBrand('Ford')" style="
                        background: var(--glass-bg);
                        backdrop-filter: blur(20px);
                        border: 1px solid var(--glass-border);
                        border-radius: 15px;
                        padding: 1.5rem;
                        text-align: center;
                        transition: all 0.3s ease;
                        cursor: pointer;
                        position: relative;
                        overflow: hidden;">
                        <div style="width: 60px; height: 60px; background: var(--gradient-gold); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; font-weight: 700; color: var(--primary-navy); font-size: 1.5rem;">
                            F
                        </div>
                        <h6 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 0.5rem;">Ford</h6>
                        <small style="color: var(--text-light);">7 vehicles</small>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6">
                    <div class="brand-card" onclick="filterByBrand('Yamaha')" style="
                        background: var(--glass-bg);
                        backdrop-filter: blur(20px);
                        border: 1px solid var(--glass-border);
                        border-radius: 15px;
                        padding: 1.5rem;
                        text-align: center;
                        transition: all 0.3s ease;
                        cursor: pointer;
                        position: relative;
                        overflow: hidden;">
                        <div style="width: 60px; height: 60px; background: var(--gradient-gold); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; font-weight: 700; color: var(--primary-navy); font-size: 1.5rem;">
                            Y
                        </div>
                        <h6 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 0.5rem;">Yamaha</h6>
                        <small style="color: var(--text-light);">3 vehicles</small>
                    </div>
                </div>
            </div>

            <!-- View All Button -->
            <div class="text-center mt-5">
                <a href="#featured-vehicles" class="btn" style="background: var(--gradient-gold); color: var(--primary-navy); border: none; border-radius: 25px; padding: 1rem 2rem; font-weight: 600; font-size: 1.1rem;">
                    <i class="fas fa-th-large me-2"></i>View All Categories
                </a>
            </div>
        </div>
    </section>

    <!-- Location Map Section -->
    <section class="section" id="location" style="background: var(--bg-gray);">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title">Our Location</h2>
                <p class="section-subtitle">Find us easily with our interactive map</p>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="map-container" style="position: relative; overflow: hidden; border-radius: 20px; box-shadow: var(--shadow-xl);">
                        <!-- Embedded Google Map -->
                        <iframe
                                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3957.580123456789!2d80.62345678901234!3d7.290123456789012!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae3681234567890%3A0x1234567890abcdef!2sSLIIT%20Kandy%20Campus!5e0!3m2!1sen!2slk!4v1699123456789!5m2!1sen!2slk"
                                width="100%"
                                height="450"
                                style="border: 0; border-radius: 20px;"
                                allowfullscreen=""
                                loading="lazy"
                                referrerpolicy="no-referrer-when-downgrade"
                                title="CarGO Location Map">
                        </iframe>

                        <!-- Map Overlay with Location Details -->
                        <div class="map-overlay" style="
                            position: absolute;
                            top: 20px;
                            left: 20px;
                            background: var(--glass-bg);
                            backdrop-filter: blur(20px);
                            border: 1px solid var(--glass-border);
                            border-radius: 15px;
                            padding: 1.5rem;
                            max-width: 300px;
                            box-shadow: var(--shadow-lg);
                            z-index: 10;">
                            <div class="d-flex align-items-center mb-3">
                                <div style="width: 50px; height: 50px; background: var(--gradient-green); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: var(--primary-navy); font-size: 1.5rem; margin-right: 1rem;">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <div>
                                    <h6 style="color: var(--primary-navy); font-weight: 700; margin: 0;">CarGO Kandy</h6>
                                    <p style="color: var(--text-light); font-size: 0.9rem; margin: 0;">Main Branch</p>
                                </div>
                            </div>
                            <div style="font-size: 0.9rem; color: var(--text-dark); line-height: 1.5;">
                                <p style="margin-bottom: 0.5rem;"><strong>📍 Address:</strong><br>KU-07 SE2030, SLIIT Kandy<br>Kandy, Central Province<br>Sri Lanka 20000</p>
                                <p style="margin-bottom: 0.5rem;"><strong>📞 Phone:</strong> 081 123 4567</p>
                                <p style="margin-bottom: 0;"><strong>🕒 Hours:</strong> Mon-Fri: 8AM-8PM</p>
                            </div>
                            <a href="#contact" class="btn" style="
                                background: var(--gradient-green);
                                color: var(--primary-navy);
                                border: none;
                                border-radius: 25px;
                                padding: 0.5rem 1rem;
                                font-size: 0.85rem;
                                font-weight: 600;
                                margin-top: 1rem;
                                width: 100%;
                                text-align: center;
                                text-decoration: none;
                                display: block;">
                                <i class="fas fa-directions me-2"></i>Get Directions
                            </a>
                        </div>

                        <!-- Map Legend -->
                        <div class="map-legend" style="
                            position: absolute;
                            bottom: 20px;
                            right: 20px;
                            background: var(--glass-bg);
                            backdrop-filter: blur(20px);
                            border: 1px solid var(--glass-border);
                            border-radius: 12px;
                            padding: 1rem;
                            box-shadow: var(--shadow-lg);
                            z-index: 10;">
                            <h6 style="color: var(--primary-navy); font-weight: 600; margin-bottom: 0.75rem; font-size: 0.9rem;">🗺️ Map Legend</h6>
                            <div style="font-size: 0.8rem; color: var(--text-dark);">
                                <div style="margin-bottom: 0.25rem;"><span style="color: var(--accent-green); font-weight: 600;">●</span> CarGO Main Office</div>
                                <div style="margin-bottom: 0.25rem;"><span style="color: var(--accent-blue); font-weight: 600;">●</span> Pickup Locations</div>
                                <div><span style="color: var(--accent-purple); font-weight: 600;">●</span> Partner Locations</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Process Steps Section -->
    <section class="section" id="process" style="background: var(--bg-white);">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title">How It Works</h2>
                <p class="section-subtitle">Simple steps to your perfect ride</p>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="text-center process-step">
                        <div class="step-number mb-3" style="width: 80px; height: 80px; background: var(--gradient-green); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto; color: var(--primary-navy); font-size: 2rem; font-weight: 700;">
                            1
                        </div>
                        <h5 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem;">Search</h5>
                        <p class="text-muted">Browse our fleet and find the perfect vehicle for your needs</p>
                        <div class="step-icon" style="font-size: 3rem; color: var(--accent-green); margin-top: 1rem;">
                            <i class="fas fa-search"></i>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="text-center process-step">
                        <div class="step-number mb-3" style="width: 80px; height: 80px; background: var(--gradient-green); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto; color: var(--primary-navy); font-size: 2rem; font-weight: 700;">
                            2
                        </div>
                        <h5 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem;">Select</h5>
                        <p class="text-muted">Choose your dates, location, and preferred vehicle</p>
                        <div class="step-icon" style="font-size: 3rem; color: var(--accent-green); margin-top: 1rem;">
                            <i class="fas fa-mouse-pointer"></i>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="text-center process-step">
                        <div class="step-number mb-3" style="width: 80px; height: 80px; background: var(--gradient-green); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto; color: var(--primary-navy); font-size: 2rem; font-weight: 700;">
                            3
                        </div>
                        <h5 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem;">Pay</h5>
                        <p class="text-muted">Secure online payment with multiple options</p>
                        <div class="step-icon" style="font-size: 3rem; color: var(--accent-green); margin-top: 1rem;">
                            <i class="fas fa-credit-card"></i>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="text-center process-step">
                        <div class="step-number mb-3" style="width: 80px; height: 80px; background: var(--gradient-green); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto; color: var(--primary-navy); font-size: 2rem; font-weight: 700;">
                            4
                        </div>
                        <h5 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem;">Drive</h5>
                        <p class="text-muted">Pick up your vehicle and enjoy your journey</p>
                        <div class="step-icon" style="font-size: 3rem; color: var(--accent-green); margin-top: 1rem;">
                            <i class="fas fa-car"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Search/Booking Bar Section -->
    <section class="section" id="booking-bar" style="background: var(--bg-white); padding: 60px 0;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="card shadow-lg" style="border-radius: 20px; overflow: hidden;">
                        <div class="card-body p-4">
                            <div class="text-center mb-4">
                                <h3 class="mb-3" style="color: var(--primary-navy); font-weight: 700;">Find Your Perfect Ride</h3>
                                <p class="text-muted">Search, compare, and book vehicles in just a few clicks</p>
                            </div>
                            <form class="row g-3">
                                <div class="col-md-3">
                                    <label class="form-label fw-semibold">
                                        <i class="fas fa-map-marker-alt me-2 text-success"></i>Pickup Location
                                    </label>
                                    <select class="form-select form-select-lg">
                                        <option selected>Colombo</option>
                                        <option>Kandy</option>
                                        <option>Galle</option>
                                        <option>Jaffna</option>
                                        <option>Negombo</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fw-semibold">
                                        <i class="fas fa-calendar-alt me-2 text-success"></i>Pickup Date
                                    </label>
                                    <input type="date" class="form-control form-control-lg" required>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fw-semibold">
                                        <i class="fas fa-clock me-2 text-success"></i>Return Date
                                    </label>
                                    <input type="date" class="form-control form-control-lg" required>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fw-semibold">
                                        <i class="fas fa-car me-2 text-success"></i>Vehicle Type
                                    </label>
                                    <select class="form-select form-select-lg">
                                        <option selected>All Types</option>
                                        <option>Car</option>
                                        <option>SUV</option>
                                        <option>Van</option>
                                        <option>Motorcycle</option>
                                    </select>
                                </div>
                                <div class="col-12 text-center mt-4">
                                    <button type="submit" class="btn btn-lg px-5 py-3" style="background: var(--gradient-green); color: var(--primary-navy); border: none; border-radius: 50px; font-weight: 700; font-size: 1.1rem;">
                                        <i class="fas fa-search me-2"></i>Search Available Vehicles
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <!-- Why Us/Features Section -->
    <section class="section features animate-on-scroll" id="features">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title">Why Choose CarGO?</h2>
                <p class="section-subtitle">Experience the difference with our premium services</p>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="text-center">
                        <div class="feature-icon mb-4">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem;">24/7 Support</h5>
                        <p class="text-muted">Round-the-clock customer service and roadside assistance</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="text-center">
                        <div class="feature-icon mb-4">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <h5 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem;">No Hidden Fees</h5>
                        <p class="text-muted">Transparent pricing with no surprise charges</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="text-center">
                        <div class="feature-icon mb-4">
                            <i class="fas fa-car"></i>
                        </div>
                        <h5 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem;">Wide Fleet</h5>
                        <p class="text-muted">50+ well-maintained vehicles for every need</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="text-center">
                        <div class="feature-icon mb-4">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h5 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem;">Easy Booking</h5>
                        <p class="text-muted">Book online in minutes with our user-friendly platform</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="text-center">
                        <div class="feature-icon mb-4">
                            <i class="fas fa-award"></i>
                        </div>
                        <h5 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem;">Premium Quality</h5>
                        <p class="text-muted">Only the finest vehicles with rigorous maintenance</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="text-center">
                        <div class="feature-icon mb-4">
                            <i class="fas fa-map-marked-alt"></i>
                        </div>
                        <h5 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem;">Island-wide Service</h5>
                        <p class="text-muted">Pickup and drop-off available across Sri Lanka</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Vehicles Section -->
    <section class="section featured-vehicles" id="featured-vehicles">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title">Featured Vehicles</h2>
                <p class="section-subtitle">Discover our premium fleet of well-maintained vehicles</p>
            </div>

            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="vehicle-card">
                        <div class="vehicle-image">
                            <img src="https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400&h=250&fit=crop&crop=center"
                                 alt="BMW 5 Series" class="img-fluid">
                        </div>
                        <div class="vehicle-content">
                            <h5 class="vehicle-title">BMW 5 Series</h5>
                            <p class="vehicle-subtitle">Luxury Sedan</p>
                            <div class="vehicle-price">Rs. 15,000<span style="font-size: 0.9rem; color: var(--text-light);">/day</span></div>
                            <a href="#home" class="btn-rent">
                                <i class="fas fa-key me-2"></i>Book Now
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="vehicle-card">
                        <div class="vehicle-image">
                            <img src="https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=400&h=250&fit=crop&crop=center"
                                 alt="Toyota Land Cruiser" class="img-fluid">
                        </div>
                        <div class="vehicle-content">
                            <h5 class="vehicle-title">Toyota Land Cruiser</h5>
                            <p class="vehicle-subtitle">Premium SUV</p>
                            <div class="vehicle-price">Rs. 18,000<span style="font-size: 0.9rem; color: var(--text-light);">/day</span></div>
                            <a href="#home" class="btn-rent">
                                <i class="fas fa-key me-2"></i>Book Now
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="vehicle-card">
                        <div class="vehicle-image">
                            <img src="https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=400&h=250&fit=crop&crop=center"
                                 alt="Honda Fit" class="img-fluid">
                        </div>
                        <div class="vehicle-content">
                            <h5 class="vehicle-title">Honda Fit</h5>
                            <p class="vehicle-subtitle">Compact Hatchback</p>
                            <div class="vehicle-price">Rs. 8,000<span style="font-size: 0.9rem; color: var(--text-light);">/day</span></div>
                            <a href="#home" class="btn-rent">
                                <i class="fas fa-key me-2"></i>Book Now
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="vehicle-card">
                        <div class="vehicle-image">
                            <img src="https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=250&fit=crop&crop=center"
                                 alt="Yamaha MT-15" class="img-fluid">
                        </div>
                        <div class="vehicle-content">
                            <h5 class="vehicle-title">Yamaha MT-15</h5>
                            <p class="vehicle-subtitle">Sports Motorcycle</p>
                            <div class="vehicle-price">Rs. 2,500<span style="font-size: 0.9rem; color: var(--text-light);">/day</span></div>
                            <a href="#home" class="btn-rent">
                                <i class="fas fa-key me-2"></i>Book Now
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="vehicle-card">
                        <div class="vehicle-image">
                            <img src="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=400&h=250&fit=crop&crop=center"
                                 alt="Toyota HiAce" class="img-fluid">
                        </div>
                        <div class="vehicle-content">
                            <h5 class="vehicle-title">Toyota HiAce</h5>
                            <p class="vehicle-subtitle">Passenger Van</p>
                            <div class="vehicle-price">Rs. 12,000<span style="font-size: 0.9rem; color: var(--text-light);">/day</span></div>
                            <a href="#home" class="btn-rent">
                                <i class="fas fa-key me-2"></i>Book Now
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="vehicle-card">
                        <div class="vehicle-image">
                            <img src="https://images.unsplash.com/photo-1494905998402-395d579af36f?w=400&h=250&fit=crop&crop=center"
                                 alt="Mazda MX-5" class="img-fluid">
                        </div>
                        <div class="vehicle-content">
                            <h5 class="vehicle-title">Mazda MX-5</h5>
                            <p class="vehicle-subtitle">Sports Convertible</p>
                            <div class="vehicle-price">Rs. 14,000<span style="font-size: 0.9rem; color: var(--text-light);">/day</span></div>
                            <a href="#home" class="btn-rent">
                                <i class="fas fa-key me-2"></i>Book Now
                            </a>
                        </div>
                    </div>
                </div>
                </div>
            </div>

            <div class="text-center mt-5">
                <a href="#booking-bar" class="btn-view-all">View All Vehicles</a>
            </div>
        </div>
    </section>




    <!-- Testimonials Section -->
    <section class="section animate-on-scroll" id="testimonials" style="background: var(--bg-gray);">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title">What Our Customers Say</h2>
                <p class="section-subtitle">Real experiences from our valued customers</p>
            </div>

            <!-- Testimonials Slider -->
            <div class="testimonial-slider">
                <div class="testimonial-item">
                    <div class="card border-0 shadow-sm" style="background: var(--bg-white);">
                        <div class="card-body p-4 text-center">
                            <div class="testimonial-avatar mb-3" style="width: 80px; height: 80px; background: var(--gradient-green); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto; color: var(--primary-navy); font-size: 2rem;">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="rating-stars mb-3">
                                ⭐⭐⭐⭐⭐
                            </div>
                            <blockquote class="blockquote mb-3">
                                <p class="mb-0">"CarGO made my trip to Sri Lanka unforgettable. The vehicle was spotless, the booking process was seamless, and the customer service was exceptional. Highly recommended!"</p>
                            </blockquote>
                            <footer class="blockquote-footer mb-0">
                                <cite title="Source Title">Sarah Johnson</cite>
                                <small class="text-muted d-block">Colombo, Sri Lanka</small>
                            </footer>
                        </div>
                    </div>
                </div>

                <div class="testimonial-item">
                    <div class="card border-0 shadow-sm" style="background: var(--bg-white);">
                        <div class="card-body p-4 text-center">
                            <div class="testimonial-avatar mb-3" style="width: 80px; height: 80px; background: var(--gradient-green); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto; color: var(--primary-navy); font-size: 2rem;">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="rating-stars mb-3">
                                ⭐⭐⭐⭐⭐
                            </div>
                            <blockquote class="blockquote mb-3">
                                <p class="mb-0">"Amazing service! I needed a vehicle for a business trip and CarGO delivered exactly what I needed. Professional staff and well-maintained cars."</p>
                            </blockquote>
                            <footer class="blockquote-footer mb-0">
                                <cite title="Source Title">Michael Chen</cite>
                                <small class="text-muted d-block">Kandy, Sri Lanka</small>
                            </footer>
                        </div>
                    </div>
                </div>

                <div class="testimonial-item">
                    <div class="card border-0 shadow-sm" style="background: var(--bg-white);">
                        <div class="card-body p-4 text-center">
                            <div class="testimonial-avatar mb-3" style="width: 80px; height: 80px; background: var(--gradient-green); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto; color: var(--primary-navy); font-size: 2rem;">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="rating-stars mb-3">
                                ⭐⭐⭐⭐⭐
                            </div>
                            <blockquote class="blockquote mb-3">
                                <p class="mb-0">"Best car rental experience I've ever had. The website is user-friendly, prices are competitive, and the vehicles are top-notch. Will definitely use again!"</p>
                            </blockquote>
                            <footer class="blockquote-footer mb-0">
                                <cite title="Source Title">Emma Rodriguez</cite>
                                <small class="text-muted d-block">Galle, Sri Lanka</small>
                            </footer>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Share Feedback Button -->
            <div class="text-center mt-5">
                <c:if test="${not empty sessionScope.username && sessionScope.role == 'customer'}">
                    <a data-bs-toggle="modal" data-bs-target="#customerFeedbackModal" class="btn" style="background: var(--gradient-green); color: var(--primary-navy); border: none; border-radius: 25px; padding: 0.75rem 2rem;">
                        <i class="fas fa-comments me-2"></i>Share Your Experience
                    </a>
                </c:if>
                <c:if test="${empty sessionScope.username}">
                    <a data-bs-toggle="modal" data-bs-target="#loginModal" class="btn" style="background: var(--gradient-green); color: var(--primary-navy); border: none; border-radius: 25px; padding: 0.75rem 2rem;">
                        <i class="fas fa-sign-in-alt me-2"></i>Login to Share Feedback
                    </a>
                </c:if>
            </div>
        </div>
    </section>



    <!-- Latest Blog/Insights Section -->
    <section class="section" id="blog-insights" style="background: var(--bg-white);">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title">Latest Insights</h2>
                <p class="section-subtitle">Stay updated with the latest trends, tips, and news from the automotive world</p>
            </div>

            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <article class="blog-card" style="
                        background: var(--glass-bg);
                        backdrop-filter: blur(20px);
                        border: 1px solid var(--glass-border);
                        border-radius: 20px;
                        overflow: hidden;
                        box-shadow: var(--shadow-lg);
                        transition: all 0.3s ease;
                        height: 100%;
                        position: relative;">
                        <div class="blog-image" style="height: 250px; overflow: hidden;">
                            <img src="https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=250&fit=crop&crop=center"
                                 alt="Electric Vehicle Revolution" style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s ease;">
                            <div class="blog-category" style="
                                position: absolute;
                                top: 15px;
                                left: 15px;
                                background: var(--gradient-navy);
                                color: white;
                                padding: 0.5rem 1rem;
                                border-radius: 20px;
                                font-size: 0.8rem;
                                font-weight: 600;">
                                Technology
                            </div>
                        </div>
                        <div class="blog-content" style="padding: 2rem;">
                            <div class="blog-meta" style="margin-bottom: 1rem;">
                                <span style="color: var(--accent-gold); font-size: 0.9rem;">
                                    <i class="fas fa-calendar me-2"></i>October 15, 2025
                                </span>
                                <span style="color: var(--text-light); font-size: 0.9rem; margin-left: 1rem;">
                                    <i class="fas fa-clock me-2"></i>5 min read
                                </span>
                            </div>
                            <h4 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem; line-height: 1.3;">
                                The Electric Vehicle Revolution: What It Means for Car Rentals
                            </h4>
                            <p style="color: var(--text-light); line-height: 1.6; margin-bottom: 1.5rem;">
                                As electric vehicles become more mainstream, car rental companies are adapting to meet the growing demand for sustainable transportation options.
                            </p>
                            <a href="#" class="blog-read-more" style="
                                color: var(--accent-gold);
                                text-decoration: none;
                                font-weight: 600;
                                font-size: 0.9rem;
                                transition: all 0.3s ease;">
                                Read More <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6">
                    <article class="blog-card" style="
                        background: var(--glass-bg);
                        backdrop-filter: blur(20px);
                        border: 1px solid var(--glass-border);
                        border-radius: 20px;
                        overflow: hidden;
                        box-shadow: var(--shadow-lg);
                        transition: all 0.3s ease;
                        height: 100%;
                        position: relative;">
                        <div class="blog-image" style="height: 250px; overflow: hidden;">
                            <img src="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=400&h=250&fit=crop&crop=center"
                                 alt="Car Maintenance Tips" style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s ease;">
                            <div class="blog-category" style="
                                position: absolute;
                                top: 15px;
                                left: 15px;
                                background: var(--gradient-gold);
                                color: var(--primary-navy);
                                padding: 0.5rem 1rem;
                                border-radius: 20px;
                                font-size: 0.8rem;
                                font-weight: 600;">
                                Maintenance
                            </div>
                        </div>
                        <div class="blog-content" style="padding: 2rem;">
                            <div class="blog-meta" style="margin-bottom: 1rem;">
                                <span style="color: var(--accent-gold); font-size: 0.9rem;">
                                    <i class="fas fa-calendar me-2"></i>October 12, 2025
                                </span>
                                <span style="color: var(--text-light); font-size: 0.9rem; margin-left: 1rem;">
                                    <i class="fas fa-clock me-2"></i>7 min read
                                </span>
                            </div>
                            <h4 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem; line-height: 1.3;">
                                Essential Car Maintenance Tips for Winter Driving
                            </h4>
                            <p style="color: var(--text-light); line-height: 1.6; margin-bottom: 1.5rem;">
                                Winter weather can be harsh on vehicles. Learn essential maintenance tips to keep your rental car running smoothly during the cold months.
                            </p>
                            <a href="#" class="blog-read-more" style="
                                color: var(--accent-gold);
                                text-decoration: none;
                                font-weight: 600;
                                font-size: 0.9rem;
                                transition: all 0.3s ease;">
                                Read More <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6">
                    <article class="blog-card" style="
                        background: var(--glass-bg);
                        backdrop-filter: blur(20px);
                        border: 1px solid var(--glass-border);
                        border-radius: 20px;
                        overflow: hidden;
                        box-shadow: var(--shadow-lg);
                        transition: all 0.3s ease;
                        height: 100%;
                        position: relative;">
                        <div class="blog-image" style="height: 250px; overflow: hidden;">
                            <img src="https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400&h=250&fit=crop&crop=center"
                                 alt="Travel Tips" style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s ease;">
                            <div class="blog-category" style="
                                position: absolute;
                                top: 15px;
                                left: 15px;
                                background: var(--gradient-navy);
                                color: white;
                                padding: 0.5rem 1rem;
                                border-radius: 20px;
                                font-size: 0.8rem;
                                font-weight: 600;">
                                Travel
                            </div>
                        </div>
                        <div class="blog-content" style="padding: 2rem;">
                            <div class="blog-meta" style="margin-bottom: 1rem;">
                                <span style="color: var(--accent-gold); font-size: 0.9rem;">
                                    <i class="fas fa-calendar me-2"></i>October 10, 2025
                                </span>
                                <span style="color: var(--text-light); font-size: 0.9rem; margin-left: 1rem;">
                                    <i class="fas fa-clock me-2"></i>4 min read
                                </span>
                            </div>
                            <h4 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 1rem; line-height: 1.3;">
                                Top 10 Road Trip Destinations in Sri Lanka
                            </h4>
                            <p style="color: var(--text-light); line-height: 1.6; margin-bottom: 1.5rem;">
                                Discover the most scenic routes and must-visit destinations for an unforgettable road trip experience across Sri Lanka.
                            </p>
                            <a href="#" class="blog-read-more" style="
                                color: var(--accent-gold);
                                text-decoration: none;
                                font-weight: 600;
                                font-size: 0.9rem;
                                transition: all 0.3s ease;">
                                Read More <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </article>
                </div>
            </div>

            <!-- Newsletter Subscription -->
            <div class="row mt-5">
                <div class="col-lg-8 mx-auto">
                    <div class="newsletter-card" style="
                        background: var(--gradient-navy);
                        border-radius: 20px;
                        padding: 3rem 2rem;
                        text-align: center;
                        color: white;
                        position: relative;
                        overflow: hidden;">
                        <div style="position: absolute; top: -50%; right: -50%; width: 200px; height: 200px; background: rgba(255, 255, 255, 0.1); border-radius: 50%;"></div>
                        <div style="position: absolute; bottom: -30%; left: -30%; width: 150px; height: 150px; background: rgba(255, 255, 255, 0.05); border-radius: 50%;"></div>
                        <div style="position: relative; z-index: 2;">
                            <div style="width: 80px; height: 80px; background: var(--gradient-gold); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 2rem; font-size: 2rem; color: var(--primary-navy);">
                                <i class="fas fa-envelope"></i>
                            </div>
                            <h3 style="font-weight: 700; margin-bottom: 1rem;">Stay In The Loop</h3>
                            <p style="opacity: 0.9; margin-bottom: 2rem; font-size: 1.1rem;">
                                Get the latest automotive news, rental deals, and travel tips delivered to your inbox
                            </p>
                            <div class="newsletter-form" style="max-width: 400px; margin: 0 auto;">
                                <div class="input-group input-group-lg">
                                    <input type="email" class="form-control" placeholder="Enter your email address" style="border-radius: 25px 0 0 25px; border: none; padding: 0.75rem 1.5rem;" required>
                                    <button class="btn" style="
                                        background: var(--gradient-gold);
                                        color: var(--primary-navy);
                                        border: none;
                                        border-radius: 0 25px 25px 0;
                                        font-weight: 600;
                                        padding: 0.75rem 1.5rem;
                                        transition: all 0.3s ease;">
                                        Subscribe <i class="fas fa-paper-plane ms-2"></i>
                                    </button>
                                </div>
                                <small style="opacity: 0.8; display: block; margin-top: 1rem;">
                                    By subscribing, you agree to our Privacy Policy. Unsubscribe at any time.
                                </small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- View All Posts Button -->
            <div class="text-center mt-5">
                <a href="#" class="btn" style="background: var(--gradient-gold); color: var(--primary-navy); border: none; border-radius: 25px; padding: 1rem 2rem; font-weight: 600; font-size: 1.1rem;">
                    <i class="fas fa-book-open me-2"></i>View All Posts
                </a>
            </div>
        </div>
    </section>

    <!-- Enhanced Call to Action Banner -->
    <section class="section cta-banner-section" style="background: linear-gradient(135deg, var(--primary-navy) 0%, #1e3a5f 100%); position: relative; overflow: hidden;">
        <div class="cta-pattern-overlay"></div>
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <div style="color: white; position: relative; z-index: 2;">
                        <h2 style="font-size: clamp(2rem, 4vw, 3rem); font-weight: 800; margin-bottom: 1rem; text-shadow: 2px 2px 4px rgba(0,0,0,0.3);">
                            <i class="fas fa-rocket me-3" style="color: var(--accent-gold);"></i>
                            Ready to Hit the Road?
                        </h2>
                        <p style="font-size: 1.2rem; opacity: 0.9; margin-bottom: 2rem; line-height: 1.6;">
                            Join thousands of satisfied customers who trust CarGO for their vehicle rental and sales needs.
                            Experience premium service, competitive prices, and unmatched reliability.
                        </p>
                        <div class="cta-stats" style="display: flex; gap: 3rem; flex-wrap: wrap; margin-bottom: 2rem;">
                            <div class="cta-stat">
                                <div style="font-size: 2rem; font-weight: 800; color: var(--accent-gold);">50+</div>
                                <div style="opacity: 0.9; font-size: 0.9rem;">Vehicle Types</div>
                            </div>
                            <div class="cta-stat">
                                <div style="font-size: 2rem; font-weight: 800; color: var(--accent-gold);">10K+</div>
                                <div style="opacity: 0.9; font-size: 0.9rem;">Happy Customers</div>
                            </div>
                            <div class="cta-stat">
                                <div style="font-size: 2rem; font-weight: 800; color: var(--accent-gold);">24/7</div>
                                <div style="opacity: 0.9; font-size: 0.9rem;">Support</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 text-lg-end">
                    <div style="position: relative; z-index: 2;">
                        <a href="#featured-vehicles" class="btn btn-cta-primary" style="
                            background: var(--gradient-gold);
                            color: var(--primary-navy);
                            border: none;
                            border-radius: 50px;
                            padding: 1rem 2rem;
                            font-weight: 700;
                            font-size: 1.1rem;
                            text-decoration: none;
                            display: inline-block;
                            margin-bottom: 1rem;
                            box-shadow: var(--shadow-lg);
                            transition: all 0.3s ease;
                            position: relative;
                            overflow: hidden;">
                            <i class="fas fa-car me-2"></i>Browse Fleet
                            <div style="position: absolute; top: 0; left: -100%; width: 100%; height: 100%; background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent); transition: left 0.5s;"></div>
                        </a>
                        <br>
                        <a href="#contact" class="btn btn-cta-secondary" style="
                            background: transparent;
                            color: white;
                            border: 2px solid var(--accent-gold);
                            border-radius: 50px;
                            padding: 1rem 2rem;
                            font-weight: 600;
                            font-size: 1rem;
                            text-decoration: none;
                            display: inline-block;
                            transition: all 0.3s ease;">
                            <i class="fas fa-phone me-2"></i>Contact Us
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section class="section contact-section animate-on-scroll" id="contact">
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
                        <a href="#location" class="btn" style="background: var(--gradient-green); color: var(--primary-navy); border: none; border-radius: 20px; padding: 0.4rem 1rem; font-size: 0.85rem; margin-top: 0.5rem;">
                            <i class="fas fa-map me-1"></i>View on Map
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <h5>Call Us</h5>
                        <p>081 123 4567<br>Mon-Fri: 8AM-8PM</p>
                        <a href="tel:+94811234567" class="btn" style="background: var(--gradient-green); color: var(--primary-navy); border: none; border-radius: 20px; padding: 0.4rem 1rem; font-size: 0.85rem; margin-top: 0.5rem;">
                            <i class="fas fa-phone me-1"></i>Call Now
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <h5>Email Us</h5>
                        <p>KU07SE2030@cargo.com<br>KU07SE@cargo.com</p>
                        <a href="mailto:KU07SE@cargo.com" class="btn" style="background: var(--gradient-green); color: var(--primary-navy); border: none; border-radius: 20px; padding: 0.4rem 1rem; font-size: 0.85rem; margin-top: 0.5rem;">
                            <i class="fas fa-envelope me-1"></i>Send Email
                        </a>
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
                        <div class="logo me-3" style="width: 50px; height: 50px; background: var(--gradient-gold); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: var(--primary-navy); font-weight: 700; font-size: 1.2rem;">🚗</div>
                        <h5 class="mb-0" style="color: white; font-weight: 700;">CarGO</h5>
                    </div>
                    <p style="color: rgba(255, 255, 255, 0.8); line-height: 1.6;">Your trusted partner for premium car rentals. Experience the freedom of the open road with our exceptional service and modern fleet across Sri Lanka.</p>
                    <div class="social-links">
                        <a href="#" style="background: rgba(255, 255, 255, 0.1);"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" style="background: rgba(255, 255, 255, 0.1);"><i class="fab fa-twitter"></i></a>
                        <a href="#" style="background: rgba(255, 255, 255, 0.1);"><i class="fab fa-instagram"></i></a>
                        <a href="#" style="background: rgba(255, 255, 255, 0.1);"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6 style="color: white; font-weight: 600; margin-bottom: 1.5rem;">Quick Links</h6>
                    <ul class="list-unstyled">
                        <li><a href="#home" style="color: #94a3b8;">Home</a></li>
                        <li><a href="#vehicles" style="color: #94a3b8;">Services</a></li>
                        <li><a href="#vehicles" style="color: #94a3b8;">Vehicles</a></li>
                        <li><a href="#location" style="color: #94a3b8;">Location</a></li>
                        <li><a href="#contact" style="color: #94a3b8;">Contact</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6 style="color: white; font-weight: 600; margin-bottom: 1.5rem;">Services</h6>
                    <ul class="list-unstyled">
                        <li><a href="#booking-bar" style="color: #94a3b8;">Car Rental</a></li>
                        <li><a href="#booking-bar" style="color: #94a3b8;">Online Booking</a></li>
                        <li><a href="#features" style="color: #94a3b8;">24/7 Support</a></li>
                        <li><a href="#features" style="color: #94a3b8;">Insurance</a></li>
                    </ul>
                </div>
                <div class="col-lg-4 col-md-4">
                    <h6 style="color: white; font-weight: 600; margin-bottom: 1.5rem;">Contact Info</h6>
                    <ul class="list-unstyled">
                        <li style="color: #94a3b8; margin-bottom: 0.5rem;"><i class="fas fa-map-marker-alt me-2" style="color: var(--accent-green);"></i>KU-07 SE2030, SLIIT Kandy</li>
                        <li style="color: #94a3b8; margin-bottom: 0.5rem;"><i class="fas fa-phone me-2" style="color: var(--accent-green);"></i>081 123 4567</li>
                        <li style="color: #94a3b8; margin-bottom: 0.5rem;"><i class="fas fa-envelope me-2" style="color: var(--accent-green);"></i>KU07SE@cargo.com</li>
                        <li style="color: #94a3b8; margin-bottom: 0.5rem;"><i class="fas fa-clock me-2" style="color: var(--accent-green);"></i>Mon-Fri: 8AM-8PM</li>
                    </ul>
                </div>
            </div>
            <hr class="my-4" style="border-color: rgba(255,255,255,0.1);">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="mb-0" style="color: #94a3b8;">&copy; 2025 CarGO. All Rights Reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <a href="#" style="color: #94a3b8;" class="me-3">Privacy Policy</a>
                    <a href="#" style="color: #94a3b8;" class="me-3">Terms of Service</a>
                    <a href="#" style="color: #94a3b8;">Cookie Policy</a>
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

    <!-- Promo Banner -->
    <div class="promo-banner" style="background: var(--gradient-green); color: var(--primary-navy); padding: 12px 0; text-align: center; font-weight: 600; position: relative; z-index: 1001;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <i class="fas fa-percentage me-2"></i>
                    <span>10% off summer bookings! Use code SUMMER10 at checkout</span>
                </div>
                <div class="col-md-4 text-md-end">
                    <button class="btn btn-sm" style="background: var(--primary-navy); color: var(--accent-green); border: none; border-radius: 20px; padding: 0.25rem 1rem;" onclick="this.parentElement.parentElement.parentElement.style.display='none'">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Newsletter Signup -->
    <div class="newsletter-section" style="background: var(--bg-gray); padding: 40px 0; border-top: 1px solid var(--border-color);">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h4 style="color: var(--primary-navy); font-weight: 700; margin-bottom: 0.5rem;">Stay Updated</h4>
                    <p style="color: var(--text-light); margin-bottom: 0;">Get the latest deals and updates delivered to your inbox</p>
                </div>
                <div class="col-lg-6">
                    <div class="input-group">
                        <input type="email" class="form-control form-control-lg" placeholder="Enter your email" style="border-radius: 25px 0 0 25px; border: 2px solid var(--border-color);">
                        <button class="btn btn-lg" style="background: var(--gradient-green); color: var(--primary-navy); border: none; border-radius: 0 25px 25px 0; font-weight: 600;">
                            Subscribe
                        </button>
                    </div>
                </div>
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

        // Enhanced button interactions
        document.querySelectorAll('.btn').forEach(btn => {
            btn.addEventListener('mousedown', function() {
                this.style.transform = 'scale(0.95)';
            });

            btn.addEventListener('mouseup', function() {
                this.style.transform = '';
            });

            btn.addEventListener('mouseleave', function() {
                this.style.transform = '';
            });
        });

        // Form field focus effects
        document.querySelectorAll('.form-control, .form-select').forEach(field => {
            field.addEventListener('focus', function() {
                this.parentElement.style.transform = 'translateY(-2px)';
            });

            field.addEventListener('blur', function() {
                this.parentElement.style.transform = '';
            });
        });

        // Add loading state to forms
        document.querySelectorAll('form').forEach(form => {
            form.addEventListener('submit', function(e) {
                const submitBtn = form.querySelector('button[type="submit"]');
                if (submitBtn) {
                    submitBtn.classList.add('loading');
                    submitBtn.disabled = true;
                }
            });
        });

        // Lazy Loading Images
        const lazyImages = document.querySelectorAll('img[data-src]');
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.classList.remove('lazy-placeholder');
                    img.onload = () => {
                        img.style.opacity = '1';
                        img.style.transform = 'scale(1)';
                    };
                    observer.unobserve(img);
                }
            });
        }, {
            rootMargin: '50px 0px',
            threshold: 0.01
        });

        lazyImages.forEach(img => {
            img.style.opacity = '0';
            img.style.transform = 'scale(0.95)';
            img.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
            imageObserver.observe(img);
        });

        // Testimonial Slider
        let currentTestimonial = 0;
        const testimonials = document.querySelectorAll('.testimonial-item');

        function showTestimonial(index) {
            testimonials.forEach((testimonial, i) => {
                testimonial.style.display = i === index ? 'block' : 'none';
            });
        }

        function nextTestimonial() {
            currentTestimonial = (currentTestimonial + 1) % testimonials.length;
            showTestimonial(currentTestimonial);
        }

        // Auto-rotate testimonials every 5 seconds
        if (testimonials.length > 1) {
            setInterval(nextTestimonial, 5000);
            showTestimonial(0); // Show first testimonial initially
        }

        // Smooth scroll with offset for fixed header
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    const headerOffset = 100;
                    const elementPosition = target.offsetTop;
                    const offsetPosition = elementPosition - headerOffset;

                    window.scrollTo({
                        top: offsetPosition,
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Counter Animation
        const counters = document.querySelectorAll('.stat-number');
        const counterObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const counter = entry.target;
                    const target = parseInt(counter.dataset.count) || parseInt(counter.textContent.replace(/[^\d]/g, ''));
                    let current = 0;
                    const increment = target / 100;
                    const duration = 2000; // 2 seconds
                    const step = duration / 100;

                    const timer = setInterval(() => {
                        current += increment;
                        if (current >= target) {
                            current = target;
                            clearInterval(timer);
                        }
                        counter.textContent = Math.floor(current).toLocaleString();
                    }, step);

                    // Add counting animation class
                    counter.style.animation = 'countUp 2s ease-out';

                    counterObserver.unobserve(counter);
                }
            });
        });

        counters.forEach(counter => {
            counterObserver.observe(counter);
        });

        // Enhanced Scroll-triggered animations with parallax
        const animateOnScroll = () => {
            const elements = document.querySelectorAll('.animate-on-scroll');

            elements.forEach(element => {
                const elementTop = element.getBoundingClientRect().top;
                const elementBottom = element.getBoundingClientRect().bottom;
                const windowHeight = window.innerHeight;

                if (elementTop < windowHeight - 100 && elementBottom > 0) {
                    element.classList.add('animate-in');
                }
            });
        };

        // Parallax Scrolling Effect
        const parallaxScroll = () => {
            const scrolled = window.pageYOffset;
            const parallaxElements = document.querySelectorAll('.parallax-element');

            parallaxElements.forEach(element => {
                const speed = element.dataset.speed || 0.5;
                const yPos = -(scrolled * speed);
                element.style.transform = `translateY(${yPos}px)`;
            });
        };

        // Enhanced scroll events for better performance
        let scrollTimeout;
        window.addEventListener('scroll', () => {
            if (!scrollTimeout) {
                scrollTimeout = setTimeout(() => {
                    animateOnScroll();
                    parallaxScroll();
                    scrollTimeout = null;
                }, 16); // ~60fps
            }
        });

        // Initial check for elements in viewport
        window.addEventListener('load', () => {
            animateOnScroll();
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

        // Category and Brand Filtering Functions
        function filterByType(type) {
            // Scroll to featured vehicles section
            document.getElementById('featured-vehicles')?.scrollIntoView({ behavior: 'smooth' });

            // Filter vehicles by type after a short delay
            setTimeout(() => {
                document.querySelectorAll('.vehicle-card').forEach(card => {
                    const vehicleType = card.querySelector('.vehicle-subtitle')?.textContent || '';
                    const shouldShow = type === 'All' || vehicleType.includes(type);
                    card.style.display = shouldShow ? 'block' : 'none';

                    // Add animation
                    if (shouldShow) {
                        card.style.opacity = '0';
                        card.style.transform = 'translateY(20px)';
                        setTimeout(() => {
                            card.style.transition = 'all 0.3s ease';
                            card.style.opacity = '1';
                            card.style.transform = 'translateY(0)';
                        }, 100);
                    }
                });

                // Show notification
                showNotification(`Showing ${type} vehicles`);
            }, 500);
        }

        function filterByBrand(brand) {
            // Scroll to featured vehicles section
            document.getElementById('featured-vehicles')?.scrollIntoView({ behavior: 'smooth' });

            // Filter vehicles by brand after a short delay
            setTimeout(() => {
                document.querySelectorAll('.vehicle-card').forEach(card => {
                    const vehicleTitle = card.querySelector('.vehicle-title')?.textContent || '';
                    const shouldShow = vehicleTitle.includes(brand);
                    card.style.display = shouldShow ? 'block' : 'none';

                    // Add animation
                    if (shouldShow) {
                        card.style.opacity = '0';
                        card.style.transform = 'translateY(20px)';
                        setTimeout(() => {
                            card.style.transition = 'all 0.3s ease';
                            card.style.opacity = '1';
                            card.style.transform = 'translateY(0)';
                        }, 100);
                    }
                });

                // Show notification
                showNotification(`Showing ${brand} vehicles`);
            }, 500);
        }

        // Reset filters function
        function resetFilters() {
            document.querySelectorAll('.vehicle-card').forEach(card => {
                card.style.display = 'block';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            });
            showNotification('Showing all vehicles');
        }

        // Service Type Toggle Functionality
        document.addEventListener('DOMContentLoaded', function() {
            const serviceTypeInputs = document.querySelectorAll('input[name="serviceType"]');
            const rentalFields = document.getElementById('rentalFields');
            const salesFields = document.getElementById('salesFields');

            serviceTypeInputs.forEach(input => {
                input.addEventListener('change', function() {
                    if (this.value === 'rental') {
                        rentalFields.style.display = 'block';
                        salesFields.style.display = 'none';
                        // Update button text and icons
                        document.querySelector('#rentalService + label').style.background = 'var(--gradient-navy)';
                        document.querySelector('#rentalService + label').style.color = 'white';
                        document.querySelector('#salesService + label').style.background = 'transparent';
                        document.querySelector('#salesService + label').style.color = 'var(--primary-navy)';
                    } else {
                        salesFields.style.display = 'block';
                        rentalFields.style.display = 'none';
                        // Update button text and icons
                        document.querySelector('#salesService + label').style.background = 'var(--gradient-gold)';
                        document.querySelector('#salesService + label').style.color = 'var(--primary-navy)';
                        document.querySelector('#rentalService + label').style.background = 'transparent';
                        document.querySelector('#rentalService + label').style.color = 'var(--primary-navy)';
                    }
                });
            });
        });

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

        // Email Domain Validation
        function validateEmailDomain(email) {
            if (!email) return false;
            const allowedDomains = ['@gmail.com', '@my.sliit.lk'];
            return allowedDomains.some(domain => email.toLowerCase().endsWith(domain));
        }

        function showEmailValidation(emailInput, isValid) {
            // Remove existing validation message
            const existingMsg = emailInput.parentNode.querySelector('.email-validation-msg');
            if (existingMsg) {
                existingMsg.remove();
            }

            // Add validation message
            const msg = document.createElement('div');
            msg.className = 'email-validation-msg mt-1';
            msg.style.fontSize = '0.875rem';

            if (!emailInput.value.trim()) {
                msg.innerHTML = '<span style="color: #6c757d;">Please enter an email address</span>';
            } else if (!isValid) {
                msg.innerHTML = '<span style="color: #dc3545;">Email must end with @gmail.com or @my.sliit.lk</span>';
                emailInput.style.borderColor = '#dc3545';
            } else {
                msg.innerHTML = '<span style="color: #198754;">✓ Valid email domain</span>';
                emailInput.style.borderColor = '#198754';
            }

            emailInput.parentNode.appendChild(msg);
        }

        function setupEmailValidation() {
            // Admin registration email validation
            const adminEmailInput = document.querySelector('#adminRegisterModal input[name="email"]');
            if (adminEmailInput) {
                adminEmailInput.addEventListener('input', function() {
                    const isValid = validateEmailDomain(this.value);
                    showEmailValidation(this, isValid);
                });
                adminEmailInput.addEventListener('blur', function() {
                    const isValid = validateEmailDomain(this.value);
                    showEmailValidation(this, isValid);
                });
            }

            // Customer registration email validation
            const customerEmailInput = document.querySelector('#registerModal input[name="email"]');
            if (customerEmailInput) {
                customerEmailInput.addEventListener('input', function() {
                    const isValid = validateEmailDomain(this.value);
                    showEmailValidation(this, isValid);
                });
                customerEmailInput.addEventListener('blur', function() {
                    const isValid = validateEmailDomain(this.value);
                    showEmailValidation(this, isValid);
                });
            }
        }

        // Form validation on submit
        function validateRegistrationForm(form) {
            const emailInput = form.querySelector('input[name="email"]');
            if (emailInput) {
                const isValid = validateEmailDomain(emailInput.value);
                if (!isValid) {
                    showEmailValidation(emailInput, false);
                    emailInput.focus();
                    return false;
                }
            }
            return true;
        }

        // Chatbot Functionality
        document.addEventListener('DOMContentLoaded', function() {
            // Setup email validation
            setupEmailValidation();

            // Add form validation to registration forms
            const adminForm = document.querySelector('#adminRegisterModal form');
            if (adminForm) {
                adminForm.addEventListener('submit', function(e) {
                    if (!validateRegistrationForm(this)) {
                        e.preventDefault();
                        return false;
                    }
                });
            }

            const customerForm = document.querySelector('#registerModal form');
            if (customerForm) {
                customerForm.addEventListener('submit', function(e) {
                    if (!validateRegistrationForm(this)) {
                        e.preventDefault();
                        return false;
                    }
                });
            }

            const chatbotToggle = document.getElementById('chatbot-toggle');
            const chatbotWindow = document.getElementById('chatbot-window');
            const chatbotClose = document.getElementById('chatbot-close');
            const chatbotInput = document.getElementById('chatbot-input-field');
            const chatbotSend = document.getElementById('chatbot-send');
            const chatbotMessages = document.getElementById('chatbot-messages');

            // Toggle chatbot window
            chatbotToggle.addEventListener('click', function() {
                chatbotWindow.style.display = chatbotWindow.style.display === 'flex' ? 'none' : 'flex';
                if (chatbotWindow.style.display === 'flex') {
                    chatbotInput.focus();
                    scrollToBottom();
                }
            });

            // Close chatbot
            chatbotClose.addEventListener('click', function() {
                chatbotWindow.style.display = 'none';
            });

            // Send message on button click
            chatbotSend.addEventListener('click', sendMessage);

            // Send message on Enter key
            chatbotInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter' && !e.shiftKey) {
                    e.preventDefault();
                    sendMessage();
                }
            });

            function sendMessage() {
                const message = chatbotInput.value.trim();
                if (message === '') return;

                // Add user message
                addMessage(message, 'user');
                chatbotInput.value = '';

                // Show typing indicator
                showTypingIndicator();

                // Get bot response after delay
                setTimeout(() => {
                    hideTypingIndicator();
                    const response = getBotResponse(message);
                    addMessage(response, 'bot');
                }, 1000 + Math.random() * 1000); // Random delay between 1-2 seconds
            }

            function addMessage(content, sender) {
                const messageDiv = document.createElement('div');
                messageDiv.className = `message ${sender}-message`;

                const messageContent = document.createElement('div');
                messageContent.className = 'message-content';
                messageContent.textContent = content;

                const messageTime = document.createElement('div');
                messageTime.className = 'message-time';
                messageTime.textContent = new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});

                messageDiv.appendChild(messageContent);
                messageDiv.appendChild(messageTime);
                chatbotMessages.appendChild(messageDiv);

                scrollToBottom();
            }

            function showTypingIndicator() {
                const typingDiv = document.createElement('div');
                typingDiv.className = 'message bot-message';
                typingDiv.id = 'typing-indicator';

                const typingIndicator = document.createElement('div');
                typingIndicator.className = 'typing-indicator';
                typingIndicator.innerHTML = '<span></span><span></span><span></span>';

                typingDiv.appendChild(typingIndicator);
                chatbotMessages.appendChild(typingDiv);
                scrollToBottom();
            }

            function hideTypingIndicator() {
                const typingIndicator = document.getElementById('typing-indicator');
                if (typingIndicator) {
                    typingIndicator.remove();
                }
            }

            function scrollToBottom() {
                chatbotMessages.scrollTop = chatbotMessages.scrollHeight;
            }

            function getBotResponse(message) {
                const lowerMessage = message.toLowerCase();

                // Car rental related responses
                if (lowerMessage.includes('hello') || lowerMessage.includes('hi') || lowerMessage.includes('hey')) {
                    return "Hello! Welcome to CarGO. How can I help you with your car rental needs today?";
                }

                if (lowerMessage.includes('book') || lowerMessage.includes('rent') || lowerMessage.includes('reservation')) {
                    return "To book a car, simply browse our fleet, select your preferred vehicle, choose your dates, and complete the booking form. You can also call us at 081 123 4567 for assistance.";
                }

                if (lowerMessage.includes('price') || lowerMessage.includes('cost') || lowerMessage.includes('rate')) {
                    return "Our prices start from Rs.5000 per day depending on the vehicle type. Luxury sedans start at Rs.10000/day. Check our fleet section for detailed pricing.";
                }

                if (lowerMessage.includes('available') || lowerMessage.includes('cars') || lowerMessage.includes('fleet')) {
                    return "We have a wide range of vehicles including sedans, SUVs, and luxury cars. You can view our current fleet in the 'Our Impressive Fleet' section above.";
                }

                if (lowerMessage.includes('document') || lowerMessage.includes('license') || lowerMessage.includes('requirement')) {
                    return "You'll need a valid driver's license, national ID, and proof of address. International customers need a valid passport and international driving permit.";
                }

                if (lowerMessage.includes('contact') || lowerMessage.includes('phone') || lowerMessage.includes('email')) {
                    return "You can reach us at:\n• Phone: 081 123 4567\n• Email: KU07SE@cargo.com\n• Address: KU-07 SE2030, SLIIT Kandy";
                }

                if (lowerMessage.includes('location') || lowerMessage.includes('pickup') || lowerMessage.includes('drop')) {
                    return "We offer pickup and drop-off services at major locations in Sri Lanka. Our main location is at KU-07 SE2030, SLIIT Kandy.";
                }

                if (lowerMessage.includes('insurance') || lowerMessage.includes('coverage')) {
                    return "All our vehicles come with comprehensive insurance coverage. Additional insurance options are available for extra peace of mind.";
                }

                if (lowerMessage.includes('cancel') || lowerMessage.includes('refund') || lowerMessage.includes('policy')) {
                    return "Cancellations can be made up to 24 hours before pickup for a full refund. Please contact us directly for cancellation requests.";
                }

                if (lowerMessage.includes('payment') || lowerMessage.includes('pay')) {
                    return "We accept credit cards, debit cards, and bank transfers. Payment is processed securely through our system.";
                }

                if (lowerMessage.includes('hours') || lowerMessage.includes('open') || lowerMessage.includes('time')) {
                    return "Our office hours are Monday to Friday, 8AM to 8PM. Emergency support is available 24/7.";
                }

                if (lowerMessage.includes('thank') || lowerMessage.includes('thanks')) {
                    return "You're welcome! If you have any other questions, feel free to ask. Happy travels with CarGO!";
                }

                if (lowerMessage.includes('bye') || lowerMessage.includes('goodbye')) {
                    return "Goodbye! Thank you for choosing CarGO. Have a great day!";
                }

                // Default responses
                const defaultResponses = [
                    "I'm here to help with your car rental questions. Could you please be more specific?",
                    "I'd be happy to assist you with information about our services. What would you like to know?",
                    "Let me help you with that. Could you tell me more about what you're looking for?",
                    "I'm CarGO's virtual assistant. I can help with booking, pricing, availability, and general inquiries."
                ];

                return defaultResponses[Math.floor(Math.random() * defaultResponses.length)];
            }
        });
    </script>

    <!-- Chatbot Widget -->
    <div id="chatbot-widget" class="chatbot-widget">
        <div class="chatbot-toggle" id="chatbot-toggle">
            <i class="fas fa-comments"></i>
        </div>
        <div class="chatbot-window" id="chatbot-window">
            <div class="chatbot-header">
                <div class="chatbot-avatar">
                    <i class="fas fa-car"></i>
                </div>
                <div class="chatbot-info">
                    <h5>CarGO Assistant</h5>
                    <span>Online</span>
                </div>
                <button class="chatbot-close" id="chatbot-close">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="chatbot-messages" id="chatbot-messages">
                <div class="message bot-message">
                    <div class="message-content">
                        Hi! I'm CarGO's virtual assistant. How can I help you today?
                    </div>
                    <div class="message-time">Just now</div>
                </div>
            </div>
            <div class="chatbot-input">
                <input type="text" id="chatbot-input-field" placeholder="Type your message..." maxlength="500">
                <button id="chatbot-send">
                    <i class="fas fa-paper-plane"></i>
                </button>
            </div>
        </div>
    </div>

    <!-- Auto-show admin promotions modal if parameter is set -->
    <c:if test="${showAdminPromotions == '1'}">
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const adminModal = new bootstrap.Modal(document.getElementById('adminPromotionModal'));
            adminModal.show();
        });
    </script>
    </c:if>

    <!-- Handle authentication messages and modals -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);

            if (urlParams.get('registration') === 'success') {
                showNotification('Registration successful! Please login to continue.');
                // Auto-open appropriate login modal
                if (urlParams.get('role') === 'admin') {
                    const adminLoginModal = new bootstrap.Modal(document.getElementById('adminLoginModal'));
                    adminLoginModal.show();
                } else {
                    const loginModal = new bootstrap.Modal(document.getElementById('loginModal'));
                    loginModal.show();
                }
            }

            if (urlParams.get('login') === '1') {
                showNotification('Login successful! Welcome back.');
            }

            if (urlParams.get('logout') === '1') {
                showNotification('You have been logged out successfully.');
            }

            if (urlParams.get('login') === 'error') {
                showNotification('Login failed! Please check your credentials and try again.');
                // Auto-open login modal
                const loginModal = new bootstrap.Modal(document.getElementById('loginModal'));
                loginModal.show();
            }

            if (urlParams.get('errorMsg')) {
                showNotification('Error: ' + decodeURIComponent(urlParams.get('errorMsg')));
            }

            if (urlParams.get('successMsg')) {
                showNotification(decodeURIComponent(urlParams.get('successMsg')));
            }
        });
    </script>

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
                            <label class="form-label">Job Role</label>
                            <select class="form-select" name="position" required>
                                <option value="">Select Role</option>
                                <option value="Fleet Supervisor">Fleet Supervisor</option>
                                <option value="Customer Service Executive">Customer Service Executive</option>
                                <option value="System Administrator">System Administrator</option>
                                <option value="Marketing Executive">Marketing Executive</option>
                                <option value="Accountant">Accountant</option>
                                <option value="Operations Manager">Operations Manager</option>
                            </select>
                        </div>
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
                            <div class="col-md-6">
                                <label class="form-label">Job Role</label>
                                <select class="form-select" name="position" required>
                                    <option value="">Select Role</option>
                                    <option value="Fleet Supervisor">Fleet Supervisor</option>
                                    <option value="Customer Service Executive">Customer Service Executive</option>
                                    <option value="System Administrator">System Administrator</option>
                                    <option value="Marketing Executive">Marketing Executive</option>
                                    <option value="Accountant">Accountant</option>
                                    <option value="Operations Manager">Operations Manager</option>
                                    <option value="Marketing">Marketing</option>
                                    <option value="Executive">Executive</option>
                                    <option value="Account">Account</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Department</label>
                                <input type="text" class="form-control" name="department" placeholder="e.g., Management" required>
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