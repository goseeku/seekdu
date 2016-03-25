(function() {
	function config($stateProvider, $locationProvider, $urlRouterProvider) {
		$locationProvider
			.html5Mode({
				enabled: false,
				requireBase: false
			})

		$stateProvider
			.state('login', {
				url: '/',
				controller: 'AuthCtrl as auth',
				templateUrl: 'auth/_login.html',
				onEnter: ['$state', 'Auth', function($state, Auth) {
					Auth.currentUser().then(function() {
						$state.go('dash');
					})
				}]
			})
			.state('register', {
				url: '/register',
				controller: 'AuthCtrl as auth',
				templateUrl: 'auth/_register.html',
				onEnter: ['$state', 'Auth', function($state, Auth) {
					Auth.currentUser().then(function() {
						$state.go('dash');
					})
				}]
			})
			.state('dash', {
				url: '/dashboard',
				controller: 'DashCtrl as dash',
				templateUrl: 'dash/_dash.html'
			})

		$urlRouterProvider.otherwise('/');
	}

	angular
		.module('seekdu', ['ui.router', 'templates', 'Devise'])
		.config(config)
})();