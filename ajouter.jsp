<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter une tâche</title>
</head>
<body>
    <nav>
        <a href="index.html">Accueil</a> |
        <a href="taches.jsp">Liste des tâches</a>
    </nav>

    <h1>Ajouter une tâche</h1>

    <form action="taches.jsp" method="post">
        <input type="hidden" name="action" value="ajouter">

        <p>
            <label for="titre">Titre :</label><br>
            <input type="text" id="titre" name="titre" required maxlength="100">
        </p>
        <p>
            <label for="description">Description :</label><br>
            <textarea id="description" name="description" required maxlength="500"></textarea>
        </p>
        <p>
            <label for="dateEcheance">Date d'échéance :</label><br>
            <input type="date" id="dateEcheance" name="dateEcheance" required>
        </p>

        <button type="submit">Ajouter la tâche</button>
    </form>
</body>
</html>