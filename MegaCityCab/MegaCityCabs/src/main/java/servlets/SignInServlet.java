package servlets;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/signIn")
public class SignInServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = UserDAO.getInstance(); // Singleton DAO

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid input: Email or password cannot be empty.");
            return;
        }

        // Admin Login Handling
        if ("admin@megacitycabs".equals(email) && "123".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user_email", email);
            session.setAttribute("user_role", "admin");

            response.getWriter().write("admin");
            return;
        }

        // Fetch User from Database
        User user = userDAO.getUserByEmail(email);
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("failure");
            return;
        }

        // Hash input password for comparison
        String inputHashedPassword = PasswordUtil.hashPassword(password);

        // Compare Passwords
        if (inputHashedPassword.equals(user.getPassword())) {
            HttpSession session = request.getSession();
            session.setAttribute("user_email", email);
            session.setAttribute("user_role", "customer");

            response.getWriter().write("customer");
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("failure");
        }
    }
}
