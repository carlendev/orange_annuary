class :home extends :x:element {
    attribute string title @required;

    protected function render(): XHPRoot {
        return (
            <x:doctype>
	    <html>
	        <head>
	            <meta charset="utf-8"/>
	            <title>{$this->:title}</title>
           	</head>
	        <body>
                   {$this->getChildren()}
	        </body>
	    </html>
            </x:doctype>
        );
  }
    
}
