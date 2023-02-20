declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method 'xhtml';
declare option output:doctype-public '-//W3C//DTD XHTML 1.0 Strict//EN';
declare option output:doctype-system 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd';
<html>
    <head>
        <link rel="stylesheet" href="style.css"/>
    </head>
    <body>
    <header>
        <h1>Mon Site de Recettes</h1>
    </header>
    <nav>
        <ul>
            <li><a href="recettes.html">Recettes</a></li>
            <li><a href="ingredients.html">Ingrédients</a></li>
            <li><a href="categories.html">Catégories</a></li>
            <li><a href="produits.html">Produits</a></li>
            <li><a href="auteurs.html">Auteurs</a></li>
        </ul>
    </nav>
        <main>{
        for $auteur in doc("recepies-transformed.xml")//auteur
        let $bio := $auteur/biographie/text()
        return
            <div id="{$auteur/@id}">
                <h2>{$auteur/nom/text()}</h2>
                <p>Pays : {$auteur/pays/text()}</p>
                <p>Sexe : {$auteur/sexe/text()}</p>
                {if (fn:string-length($bio) > 0) then 
                    <p>Biographie : {$bio}</p>
                 else ()
                }
                <p>Listes des recettes :
                <ul>
                {
                    for $idr in $auteur/ref-recette/@ref
                    return
                        for $recette in doc("recepies-transformed.xml")//recette
                        where $recette/@id = $idr
                        return
                            <li><a href="recettes.html#{$idr}">{$recette/titre/text()}</a></li>
                }
                </ul></p>
                <p>Listes des catégories :
                <ul>
                {
                    
                    let $categories := distinct-values(doc("recepies-transformed.xml")//recette[@id=$auteur/ref-recette/@ref]/@sous-categorie)
                    for $cate in $categories
                    return
                        <li><a href="categories.html#{$cate}">{//sous-categorie[@id=$cate]/nom/text()}</a></li>
                }
                </ul></p>
            </div>
        }
        </main>
    <footer>
        <p>2023 Mon Site de Recettes</p>
    </footer>
    </body>
</html>