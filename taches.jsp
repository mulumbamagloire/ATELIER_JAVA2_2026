<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="taches.Task" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 1. Récupérer la liste des tâches en session (ou la créer si elle n'existe pas)
    ArrayList<Task> listeTaches = (ArrayList<Task>) session.getAttribute("taches");
    if (listeTaches == null) {
        listeTaches = new ArrayList<Task>();
        session.setAttribute("taches", listeTaches);
    }

    // 2. Traiter l'action envoyée par le formulaire
    String action = request.getParameter("action");
    if ("POST".equalsIgnoreCase(request.getMethod()) && action != null) {

        if ("ajouter".equals(action)) {
            String titre = request.getParameter("titre");
            String description = request.getParameter("description");
            String dateEcheance = request.getParameter("dateEcheance");
            if (titre != null && !titre.trim().isEmpty()
                    && description != null && !description.trim().isEmpty()) {
                listeTaches.add(new Task(titre.trim(), description.trim(), dateEcheance));
            }

        } else if ("supprimer".equals(action)) {
            try {
                int index = Integer.parseInt(request.getParameter("index"));
                if (index >= 0 && index < listeTaches.size()) {
                    listeTaches.remove(index);
                }
            } catch (NumberFormatException e) {
                // index invalide : on ignore
            }

        } else if ("terminer".equals(action)) {
            try {
                int index = Integer.parseInt(request.getParameter("index"));
                if (index >= 0 && index < listeTaches.size()) {
                    Task t = listeTaches.get(index);
                    t.setTerminee(!t.isTerminee());   // bascule l'état
                }
            } catch (NumberFormatException e) {
                // index invalide : on ignore
            }
        }

        // 3. Pattern POST-Redirect-GET, commun à toutes les actions
        response.sendRedirect("taches.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mes tâches</title>
</head>
<body>
    <nav>
        <a href="index.html">Accueil</a> |
        <a href="ajouter.jsp">Ajouter une tâche</a>
    </nav>

    <h1>Mes tâches (<%= listeTaches.size() %>)</h1>

    <% if (listeTaches.isEmpty()) { %>
        <p><em>Aucune tâche pour le moment. Ajoutez votre première tâche !</em></p>
    <% } else { %>
        <table border="1" cellpadding="8" cellspacing="0">
            <tr>
                <th>#</th>
                <th>Titre</th>
                <th>Description</th>
                <th>Échéance</th>
                <th>Statut</th>
                <th>Actions</th>
            </tr>
            <%-- Boucle sur la liste stockée en session --%>
            <% for (int i = 0; i < listeTaches.size(); i++) {
                   Task t = listeTaches.get(i); %>
            <tr>
                <td><%= i + 1 %></td>
                <td><strong><%= t.getTitre() %></strong></td>
                <td><%= t.getDescription() %></td>
                <td><%= t.getDateEcheance() %></td>
                <td><%= t.isTerminee() ? "✔ Terminée" : "⏳ En cours" %></td>
                <td>
                    <form action="taches.jsp" method="post" style="display:inline">
                        <input type="hidden" name="action" value="terminer">
                        <input type="hidden" name="index" value="<%= i %>">
                        <button type="submit">
                            <%= t.isTerminee() ? "↩ Rouvrir" : "✔ Terminer" %>
                        </button>
                    </form>
                    <form action="taches.jsp" method="post" style="display:inline"
                          onsubmit="return confirm('Supprimer cette tâche ?');">
                        <input type="hidden" name="action" value="supprimer">
                        <input type="hidden" name="index" value="<%= i %>">
                        <button type="submit">🗑 Supprimer</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    <% } %>
</body>
</html>