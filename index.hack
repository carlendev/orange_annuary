require_once(__DIR__.'/vendor/hh_autoload.php');

use HH\Lib\Vec;
use HH\Lib\C;


class :main extends :x:element {
      attribute string title @required;

      protected function render(): XHPRoot {
      		return ( <x:doctype>
		<html>
			<head>
				<meta charset="utf-8" />
				<title>{$this->:title}</title>
			</head>
			<body>
			<h1>{$this->:title}</h1>
			{$this->getChildren()}
			</body>
		</html>
		</x:doctype> );
      }

}

interface IController {


	  public function render() : void;

}


abstract class AbstractController implements IController {

	 public function render() : void {}

}

enum Actions : string {
     DEFAULT =        'default';
     ADD     =	      'add';
}

type Route = shape('action' => Actions, 'controller' => AbstractController);

function action_route(Actions $action) : string {
	 return \sprintf("?action=%s", $action);
}

function throw_404(): noreturn {
	 http_response_code(404);
	 echo <main title="404 Not Found">
	 	 <a href={action_route(Actions::DEFAULT)}>Back to Home</a>
	 </main>;
	 exit(0);

}

function get_action(?string $action = "default") : string {
	 return strtolower($_GET['action'] ?? $action);
}

function filter_action(string $action) : Actions {
	$actions = Actions::getNames();
	foreach ($actions as $value => $key) {
	    if ($value == $action) return $value;
	}
	throw_404();
}

final class HomeController extends AbstractController implements IController {

      <<__Override>>
      public function render() : void {
             echo <main title="Prospect CRM">
	     	  <p>Liste des prospects</p>
	     </main>;
      }

}

function call_controller(vec<Route> $routes) : void {
	  $action = get_action() |> filter_action($$);
	  $controller =  C\find($routes, $route ==> $action == $route['action'])['controller'];
	  $controller->render();
}

<<__EntryPoint>>
function main(): noreturn {
/*	  echo test();
	  $a = [1, 2, null, 3];
	  var_dump(Vec\filter_nulls($a) |> Vec\map($$, $a ==> $a * $a) |> Vec\sort($$));*/
	  $routes = vec[ shape('action' => Actions::DEFAULT, 'controller' => new HomeController()) ];
	  call_controller($routes);
	  exit(0);
}