'use strict';

import { Elm } from './elm/Main';
import './assets/sass/styles.scss';

(function () {
    const node: HTMLElement | null = document.getElementById('elm');
    const app = Elm.Main.init({
        node: node,
        flags: null
    });
})();