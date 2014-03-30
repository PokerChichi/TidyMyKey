#ifndef _SYMBOLE_
#define _SYMBOLE_

#include <string>
#include "TI.hpp"

class Symbole {

private : 
	TableDesIdentificateurs tableId;	
	
public : 
	std::string nom;
	int categorie;
	int type;
	int typeContenu;
	char* borneinf;
	char* bornesup;
	char* valeur;
	int arite;
	int typeRetour;


	Symbole();
	Symbole(std::string);
	~Symbole();

	int getId(std::string);
	std::string getNom();
	void setCategorie(int);
	int getCategorie();
	std::string getStringCategorie();
	void setType(int);
	int getType();
	std::string getStringType(int);
	std::string getString(std::string, std::string);
	std::string getStringDonnee();

	enum Categorie {CONSTANTE, VARIABLE, PROGRAMME, FONCTION, PROCEDURE, ARGUMENT, TYPE};
	std::string CategMap[7]={"constante", "variable", "programme", "fonction", "procedure", "argument", "type"};

	enum Type {ENTIER, REEL, BOOLEEN, CHAINE, CARACTERE, POINTEUR, TABLEAU};
	std::string TypeMap[7]={"entier", "reel", "booleen", "chaine", "caractere", "pointeur", "tableau"};
	

};

#endif
