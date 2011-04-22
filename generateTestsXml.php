<?php
	$dir = isset($argc) && $argc > 0 ? $argv[1] : "../InspireBrowser/doc/xml/";

	function AddFromXml(DomDocument $doc, DomNode $parent, $xml, $path = "webroot/") {
		$subsystems = $xml->xpath("//sectiondef/memberdef[@kind='variable']");
		foreach($subsystems as $subsystem) {
			if(!isset($subsystem->type->ref))
				continue;
			
			$subSystemXml = LoadClass($subsystem->type->ref['refid']);
			if($subSystemXml === FALSE) 
				continue;

			$parentClass = (string)$subSystemXml->compounddef->basecompoundref;
			if($parentClass !== "IJSBinding")
				continue;

			$name = (string)$subsystem->type->ref;
			
			$node = $parent->appendChild($doc->createElement("subsystem"));
			$node->appendChild($doc->createElement("name", $name));
			AddFromXml($doc, $node, $subSystemXml, "${path}${name}/");
		}

		$properties = $xml->xpath("//sectiondef/memberdef[@kind='property'][@prot='public']");
		foreach($properties as $property) {
			$name = (string)$property->name;

			$node = $parent->appendChild($doc->createElement("property"));
			$node->appendChild($doc->createElement("name", $name));

			AddTests($doc, $node, "${path}${name}/");
		}

		$functions = $xml->xpath("//sectiondef/memberdef[@kind='slot'][@prot='public']");
		foreach($functions as $function) {
			$name = (string)$function->name;

			$node = $parent->appendChild($doc->createElement("function"));
			$node->appendChild($doc->createElement("name", $name));

			AddTests($doc, $node, "${path}${name}/");
		}

		$events = $xml->xpath("//sectiondef/memberdef[@kind='signal'][@prot='public']");
		foreach($events as $event) {
			$name = (string)$event->name;

			$node = $parent->appendChild($doc->createElement("event"));
			$node->appendChild($doc->createElement("name", $name));

			AddTests($doc, $node, "${path}${name}/");
		}
		AddTests($doc, $parent, $path);
	}

	function AddTests(DomDocument $doc, DomNode $parent, $path) {
		if(empty($path))
			return;
		
		if(!file_exists($path))
			mkdir($path, 0777, true);
		
		$tests = glob("$path*.xml");
		if(count($tests) < 1)
			return;

		foreach($tests as $test) {
			$id = basename($test, ".xml");
			
			$xml = simplexml_load_file($test);
			$name = (string)$xml->name;
			$description = (string)$xml->description;

			$node = $parent->appendChild($doc->createElement("test"));
			$node->appendChild($doc->createElement("name", $name));
			$node->appendChild($doc->createElement("description", $description));
			$node->appendChild($doc->createElement("id", $id));
		}
	}

	function LoadClass($className) {
		global $dir;
		return simplexml_load_file("${dir}/${className}.xml");
	}
	
	$doc = new DomDocument("1.0", "UTF-8");
	$doc->formatOutput = true;
	$root = $doc->appendChild($doc->createElement("binding"));
	AddFromXml($doc, $root, LoadClass("class_inspire_web_view"));
	
	header("Content-Type: text/xml");
	echo $doc->saveXml();
?>
