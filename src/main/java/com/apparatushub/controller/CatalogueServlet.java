package com.apparatushub;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/catalogue")
public class CatalogueServlet extends HttpServlet {

    public static class Apparatus {
        private String id;
        private String name;
        private String category;
        private int quantity;
        private String condition;
        private String labName;
        private String listingType;
        private String ownerFaculty;
        private String vendorOrRenter;
        private String description;

        public Apparatus(String id, String name, String category, int quantity, String condition,
                String labName, String listingType, String ownerFaculty,
                String vendorOrRenter, String description) {
            this.id = id;
            this.name = name;
            this.category = category;
            this.quantity = quantity;
            this.condition = condition;
            this.labName = labName;
            this.listingType = listingType;
            this.ownerFaculty = ownerFaculty;
            this.vendorOrRenter = vendorOrRenter;
            this.description = description;
        }

        public String getId() {
            return id;
        }

        public String getName() {
            return name;
        }

        public String getCategory() {
            return category;
        }

        public int getQuantity() {
            return quantity;
        }

        public String getCondition() {
            return condition;
        }

        public String getLabName() {
            return labName;
        }

        public String getListingType() {
            return listingType;
        }

        public String getOwnerFaculty() {
            return ownerFaculty;
        }

        public String getVendorOrRenter() {
            return vendorOrRenter;
        }

        public String getDescription() {
            return description;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Apparatus> catalogueList = new ArrayList<>();

        catalogueList.add(new Apparatus("APP-101", "8086 Microprocessor Kit", "Microprocessors", 15, "Available",
                "Microprocessor Lab", "Rent", "A. P. Shah Computer Faculty", "KC College of Engineering",
                "Kit with 8086 CPU board, display, and keypads for assembly programming practicals."));

        catalogueList.add(new Apparatus("APP-102", "Digital Oscilloscope 100MHz", "Oscillators", 6, "Available",
                "EDC Lab", "Buy", "A. P. Shah EXTC Faculty", "Thane Electronics Local",
                "Dual-channel digital storage oscilloscope for waveform signal analysis."));

        catalogueList.add(new Apparatus("APP-103", "Intel Core i7 Workstation PC", "Computers", 25, "In Use",
                "Software Engineering Lab", "Rent", "A. P. Shah IT Faculty", "New Horizon Institute of Technology",
                "High-performance desktop computer setup reserved for inter-collegiate hackathons and exams."));

        catalogueList.add(new Apparatus("APP-104", "Mechanical Pulley & Load Setup", "Mechanical", 10, "Available",
                "Applied Mechanics Lab", "Buy", "A. P. Shah Mechanical Faculty", "Thane Hardware & Tools",
                "Triple-tandem mechanical pulley system for force and tension lab experiments."));

        catalogueList.add(new Apparatus("APP-105", "Digital Voltmeter 0-500V", "Electrical Measuring", 20, "Available",
                "Basic Electrical Lab", "Buy", "A. P. Shah Electrical Faculty", "Thane Electricals",
                "Precision panel meter for AC/DC voltage measurement across circuit testboards."));

        catalogueList.add(new Apparatus("APP-106", "Borosilicate Test Tubes (Set of 50)", "Glassware", 8, "Available",
                "Chemistry Lab", "Buy", "A. P. Shah Applied Science Faculty", "Thane Scientific & Chemicals",
                "Heat-resistant glass test tubes for qualitative analysis and chemical reaction experiments."));

        catalogueList.add(new Apparatus("APP-107", "Concentrated Hydrochloric Acid (HCl 500ml)", "Chemicals", 4,
                "Under Maintenance",
                "Chemistry Lab", "Rent", "A. P. Shah Applied Science Faculty", "KC College Chemistry Department",
                "Lab-grade reagent bottle for titration practicals under supervisor authorization."));

        catalogueList.add(new Apparatus("APP-108", "Mechanical USB Keyboards", "Peripherals", 30, "Available",
                "Computer Center", "Buy", "A. P. Shah Computer Faculty", "Thane Local IT Traders",
                "Standard 104-key USB keyboards for lab terminal replacements."));

        catalogueList.add(new Apparatus("APP-109", "Intel Xeon Server CPU Module", "CPUs", 2, "Available",
                "Advanced Computing Lab", "Rent", "A. P. Shah Computer Faculty", "New Horizon Computer Department",
                "Server processor module available on short-term rental for specialized high-performance computing labs."));

        catalogueList.add(new Apparatus("APP-110", "Vernier Caliper 0-150mm", "Workshop Tools", 12, "Available",
                "Engineering Workshop", "Buy", "A. P. Shah Mechanical Faculty", "Thane Precision Tools",
                "Stainless steel analog vernier caliper for precise mechanical measuring practicals."));

        catalogueList.add(new Apparatus("APP-111", "Micrometer Screw Gauge 0-25mm", "Workshop Tools", 10, "Available",
                "Engineering Workshop", "Buy", "A. P. Shah Mechanical Faculty", "Thane Industrial Suppliers",
                "High-precision micrometer for measuring wire gauge and sheet metal thickness."));

        catalogueList.add(new Apparatus("APP-112", "Bench Vice 100mm Jaw", "Workshop Tools", 8, "Available",
                "Fitting Shop", "Buy", "A. P. Shah Mechanical Faculty", "Thane Hardware Mart",
                "Heavy-duty cast iron bench vice for clamping metal workpieces during fitting jobs."));

        catalogueList.add(new Apparatus("APP-113", "Portable Arc Welding Machine", "Workshop Tools", 3, "In Use",
                "Welding Shop", "Rent", "A. P. Shah Mechanical Faculty", "KC College Mechanical Dept",
                "Single-phase inverter arc welding machine with protective face shield and tongs."));

        catalogueList.add(new Apparatus("APP-114", "Carpentry Hand Saw & Chisel Set", "Workshop Tools", 15, "Available",
                "Carpentry Shop", "Buy", "A. P. Shah Workshop Instructors", "Thane Timber & Tools",
                "Complete woodworking set including crosscut saw, wood chisels, and wooden mallet."));

        catalogueList.add(new Apparatus("APP-115", "Sheet Metal Hand Shears & Snips", "Workshop Tools", 10, "Available",
                "Smithy & Sheet Metal Shop", "Buy", "A. P. Shah Workshop Instructors", "Thane Hardware Mart",
                "Heavy-duty metal cutting shears for sheet metal development practicals."));

        request.setAttribute("catalogueList", catalogueList);
        request.getRequestDispatcher("/catalogue.jsp").forward(request, response);
    }
}