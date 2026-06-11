package classes.taches;

import java.io.Serializable;

public class Task implements Serializable {

    private String titre;
    private String description;
    private String dateEcheance;   // format "yyyy-MM-dd" (celui de <input type="date">)
    private boolean terminee;

    // Constructeur
    public Task(String titre, String description, String dateEcheance) {
        this.titre = titre;
        this.description = description;
        this.dateEcheance = dateEcheance;
        this.terminee = false;   // une nouvelle tâche n'est jamais terminée
    }

    // Getters / Setters
    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getDateEcheance() { return dateEcheance; }
    public void setDateEcheance(String dateEcheance) { this.dateEcheance = dateEcheance; }

    public boolean isTerminee() { return terminee; }
    public void setTerminee(boolean terminee) { this.terminee = terminee; }
}