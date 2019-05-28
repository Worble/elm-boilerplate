const merge = require('webpack-merge');
const common = require('./webpack.common.js');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const webpack = require('webpack');

module.exports = merge(common, {
    mode: 'development',

    module: {
        rules: [{
            test: /\.elm$/,
            exclude: [/elm-stuff/, /node_modules/],
            use: ['elm-loader']
        }, {
            test: /\.(css|sass|scss)$/,
            use: [
                'style-loader',
                'css-loader',
                'sass-loader'
            ]
        }]
    },

    devServer: {
        historyApiFallback: true,
        contentBase: 'static',
        watchContentBase: true,
        watchOptions: {
            ignored: /node_modules/
        }
    },

    plugins: [
        new webpack.HotModuleReplacementPlugin(),
        new HtmlWebpackPlugin({
            template: 'static/index.html',
        })
    ]
});