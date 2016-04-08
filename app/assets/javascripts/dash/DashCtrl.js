(function() {
	function DashCtrl($scope, Auth) {
		this.logout = Auth.logout;
	}

	angular
		.module('seekdu')
		.controller('DashCtrl', ['$scope', 'Auth', DashCtrl])
})();