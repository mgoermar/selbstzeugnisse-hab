<?php

    $title = 'Selbstzeugnisse der Frühen Neuzeit in der Herzog August Bibliothek';
    $homelink = 'index.php?cPage=0&sPage=0';

    $navList = Array(); $c = 0;

    $navList[$c]['title'] = "Projekt";

    $c++; $navList[$c]['title'] = "Repertorium"; $navList[$c]['subMen'] = Array("Suche", "Liste",'Register');
    
    $c++; $navList[$c]['title'] = "Editionen";
    $navList[$c]['subMen'] = Array("Diarium August II.", 'Tagebücher Ludwig Rudolphs und Christine Luises');
    
    $c++; $navList[$c]['title'] = "Ähnliche Projekte";
    $c++; $navList[$c]['title'] = "Weiterführende<br/>Literatur";
    $c++; $navList[$c]['title'] = "Dienste";
    $c++; $navList[$c]['title'] = "Impressum";

?><!DOCTYPE html>
<html>

    <head>
    
        <meta http-equiv="content-type" content="text/html;charset=utf-8"/>
		
        <meta name="viewport" content="width=device-width, initial-scale=1">

		<meta name="description" content="xxxxxxxxxxxxxxxxxxxx">
		<meta lang="de" name="keywords" content="xxxxxxxxxxxxxxxx">
		<meta http-equiv="expires" content="0">
		<meta name="robots" content="INDEX,FOLLOW">
		<meta name="author" content="Christof Bobzin">
		<meta name="publisher" content="xxxxxxxxxxxx">
		<meta name="copyright" content="xxxxxxxxxxxx">
		<link rel="shortcut icon" href="favicon_hdk.ico"/> 

        <link rel="preconnect" href="https://fonts.gstatic.com"> 
        <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&display=swap" rel="stylesheet">
	
        <link href="reset.css" type="text/css" rel="stylesheet"/>
        <link href="assets/font-awesome/css/font-awesome.min.css" media="screen" rel="stylesheet">

        <link href="styles.css" type="text/css" rel="stylesheet"/>
        <link href="diarium.css" type="text/css" rel="stylesheet"/>
		
        <script type="text/javascript" src="assets/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="assets/jquery-zoom/jquery.zoom.min.js"></script>
        <script type="text/javascript" src="assets/js/selbstzeugnisse.js"></script>
        <noscript><style type="text/css">.js-toggle { display: inherit; }</style></noscript>

        <title><?php echo $title; ?></title>
        
        <script language="javascript" type="text/javascript">
			
			
			
		</script>
        
    </head>
    <body>

        <div id="mainConti">

            <header>

                <div id="bgTop"></div>
                <a href="<?php echo $homelink; ?>" id="logo"></a>
                
                <div id="m_titleConti">
                    <span id="m_title1">Selbstzeugnisse&nbsp;</span><span id="m_title2">der frühen Neuzeit</span><br/>
                    <span id="m_subTitle">in der Herzog August Bibliothek</span>
                </div>
                
                <a href="http://www.hab.de" target="_blank" id="habLogo"></a>

            </header>

            <nav role="navigation">
                <div id="menuToggle">
                    
                    <input type="checkbox" />
            
                    <span></span>
                    <span></span>
                    <span></span>


                            <ul id="menu">
<?php $i = 0; foreach($navList as $nav){

?>
                                <li><a href="index.php?cPage=<?php echo $i; ?>&sPage=0&ePage=0"<?php if($i == $_SESSION['c_page']){ echo " class=\"sel\""; } ?>><?php echo $nav['title'] ?></a>
                                <?php /*if($nav['subMen'] != "" && $i == $_SESSION['c_page']){*/
                                    ?><ul id="subMen"><div style="padding-top:10px;">
                                    <?php
                                    $s = 0; foreach($nav['subMen'] as $subPoint){
                                        ?><li><a href="index.php?cPage=<?php echo $i; ?>&sPage=<?php echo $s; ?>&ePage=0&regMode=0&hlFind=0"<?php if($s == $_SESSION['s_page']){ echo " class=\"sel\""; } ?>><?php echo $subPoint; ?></a></li>
                                        <?php
                                    $s++; }
                                    ?></div></ul>
                                <?php //} ?></li>
<?php $i++; } ?>
                            </ul>
                </div>
            </nav>

            <a class="printer" href="#"></a>

            <!-- <article> -->
                
                <div class="content">
                    
                    <?php
                    
                    if($_GET['cPage'] == 0){

                        include('boxes.inc.php');

                    }else if($_GET['cPage'] == 1){

                        if($_GET['sPage'] == 0){

                            include('suche001.inc.php');

                        }elseif($_GET['sPage'] == 1){

                            include('repertorium002.inc.php');

                        }else{

                            include('register001.inc.php');

                        }

                    }else if($_GET['cPage'] == 3){

                        include('content.inc.php');

                    }else{
                        
                        include('diarium002.inc.php');
                    
                    }
                        
                    ?>
                    
                </div>

            <!-- </article> -->

            <footer>

            </footer>

        </div>

    </body>

</html>