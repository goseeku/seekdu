(function() {
	function config($stateProvider, $locationProvider, $urlRouterProvider) {
		$locationProvider
			.html5Mode({
				enabled: true,
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
					});
				}]
			})
			.state('register', {
				url: '/register',
				controller: 'AuthCtrl as auth',
				templateUrl: 'auth/_register.html',
				onEnter: ['$state', 'Auth', function($state, Auth) {
					Auth.currentUser().then(function() {
						$state.go('dash');
					});
				}]
			})
			.state('pwreset', {
				url: '/pwreset',
				controller: 'AuthCtrl as auth',
				templateUrl: 'auth/_pwreset.html',
				onEnter: ['$state', 'Auth', function($state, Auth, creds) {
					Auth.sendResetPasswordInstructions(creds).then(function() {
						$state.go('login');
					});
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