<?php
	if(file_exists("config.php"))
		include("config.php");
	
	$isTest = false;
	
	if(!isset($dir))
		$dir = dirname($_SERVER["SCRIPT_FILENAME"]);
	if(!isset($configDir))
		$configDir = "${dir}/../";

	if(isset($_GET['test'])) {
		$path = $_GET['test'];
		$isTest = true;
	}
	else if(isset($_GET['path']))
		$path = $_GET['path'];
	else
		$path = "";

	$pathSections = array_values(array_filter(explode("/", $path)));

	$doc = new DomDocument();
	$xsl = new DOMDocument();

	$found = false;
	if($isTest) {
		$doc->Load("${dir}/${path}.xml");
		$xpath = new DOMXPath($doc);
		$name = $xpath->evaluate("string(//test/name/text())");
		$pathSections[count($pathSections) - 1] = $name;
		$found = true;
	} else {
		$xpath = Array("/binding");
		foreach($pathSections as $pathSection)
			$xpath[] = "/*/name[.='$pathSection']/..";
		$xpathQuery = implode("", $xpath);
		
		$doc->Load("${configDir}/inspire_tests.xml");
		$xpath = new DOMXPath($doc);
		$entries = $xpath->query($xpathQuery);
				
		if($entries->length > 0) {
			$doc = new DomDocument();
			$doc->appendChild($doc->importNode($entries->item(0), true));
			$found = true;
		}
	}
	
	$xsl->load($isTest ? "${configDir}/test.xslt" : "${configDir}/section.xslt");
?>
<!doctype html>
	<head>
		<title><?=count($pathSections) > 0 ? implode(" :: ", $pathSections) : "Inspire Tests"?></title>
		<meta charset="utf-8" />
		<link rel="stylesheet" media="all" href="css/InspireTests.css">
		<script src="scripts/modernizr-1.6.min.js"></script>
		<script src="scripts/jquery-1.4.4.min.js"></script>
		<script src="scripts/InspireTests.js"></script>
		<? if($isTest) { ?>
		<script src="scripts/register_test.js"></script>
		<? } ?>
	</head>
	<body>
		<header>
			<h1>Inspire Browser Test Center</h1>
			<ul class="breadcrumb">
				<li><a href="?path=">Inspire Tests</a></li>
				<?php
					for($i=0; $i<count($pathSections); $i++) {
						?>
						<li><a href="?path=<?=implode("/", array_slice($pathSections, 0, $i+1))?>"><?=$pathSections[$i]?></a></li>
						<?php
					}
				?>
			</ul>
		</header>
		<?php
			if(!$found) {
				?>
					<h2>Test / Page not found for path <?=$path?></h2>
				<?
			} else {
				$proc = new XSLTProcessor();
				$proc->importStyleSheet($xsl); // attach the xsl rules
				$proc->setParameter("", "path", $path);

				echo $proc->transformToXML($doc);
			}
		?>
	</body>
</html>