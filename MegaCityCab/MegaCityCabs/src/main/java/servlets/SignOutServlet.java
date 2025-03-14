package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/SignOut")
public class SignOutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get existing session without creating a new one

        if (session != null) {
            // Debugging: print the user email of the logged-in user
            System.out.println("Signing out user: " + session.getAttribute("user_email"));

            // Remove user-specific attributes
            session.removeAttribute("user_email");
            session.removeAttribute("user_role");

            // Invalidate the session
            session.invalidate();
        }

        // Redirect to the home page with session tracking prevention
        response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/customer/home.jsp"));
    }
}
