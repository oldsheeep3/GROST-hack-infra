declare const require: any;
declare const module: any;

console.log('Hello from template-node (TypeScript)');

export function main() {
	console.log('App started');
}

if (typeof require !== 'undefined' && require.main === module) {
	main();
}
