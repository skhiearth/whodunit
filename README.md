# whodunit

who? what? when? where?
Blockchain intersects real-world conditions for this quirky betting game.

### Deploy contracts on your own?

After cloning the repository, navigate to the `whodunit` folder and create a new file called `secret.js`. Add the following to the file:

```js
const MNEMONIC = "";

export { MNEMONIC };
```

Add your MNEMONIC in the double quotes and then use `truffle compile` and `truffle deploy --network iotex --reset` to compile and deploy the contract to the network.