{include file="orderforms/standard_cart/common.tpl"}

<div id="order-standard_cart">
    <div class="row">
        <div class="cart-sidebar sidebar">
            {include file="orderforms/standard_cart/sidebar-categories.tpl"}
        </div>
        <div class="cart-body">

            <div class="header-lined">
                <h1 class="font-size-36">
                    {if $productGroup.headline}
                        {$productGroup.headline}
                    {else}
                        {$productGroup.name}
                    {/if}
                </h1>
                {if $productGroup.tagline}
                    <p>{$productGroup.tagline}</p>
                {/if}
            </div>
            {if $errormessage}
                <div class="alert alert-danger">
                    {$errormessage}
                </div>
            {elseif !$productGroup}
                <div class="alert alert-info">
                    {lang key='orderForm.selectCategory'}
                </div>
            {/if}

            {include file="orderforms/standard_cart/sidebar-categories-collapsed.tpl"}

            <div class="products" id="products">
                <div class="row row-eq-height">
                    {foreach $products as $key => $product}
                        {$idPrefix = ($product.bid) ? ("bundle"|cat:$product.bid) : ("product"|cat:$product.pid)}
                        {* Determine if this is the recommended plan (typically Weekly or middle plan) *}
                        {$isRecommended = ($key == 1 && $products|@count >= 3) || $product.pricing.minprice.cycle eq "weekly" || (isset($product.recommended) && $product.recommended)}
                    <div class="col-lg-4 col-md-6 col-sm-12">
                        <div class="product-card{if $isRecommended} recommended{/if}" id="{$idPrefix}">
                            {if $isRecommended}
                                <div class="recommended-badge">
                                    <span>Recommended</span>
                                </div>
                            {/if}
                            <header class="product-header">
                                <h3 class="product-title" id="{$idPrefix}-name">{$product.name}</h3>
                                {if $product.stockControlEnabled}
                                    <span class="product-qty">
                                        {$product.qty} {$LANG.orderavailable}
                                    </span>
                                {/if}
                            </header>
                            <div class="product-pricing-section" id="{$idPrefix}-price">
                                {if $product.bid}
                                    <div class="price-label">{$LANG.bundledeal}</div>
                                    {if $product.displayprice}
                                        <div class="price-main">{$product.displayprice}</div>
                                    {/if}
                                {else}
                                    {if $product.pricing.hasconfigoptions}
                                        <div class="price-label">{$LANG.startingfrom}</div>
                                    {/if}
                                    <div class="price-main">{$product.pricing.minprice.price}</div>
                                    <div class="price-cycle">
                                        {if $product.pricing.minprice.cycle eq "monthly"}
                                            {$LANG.orderpaymenttermmonthly}
                                        {elseif $product.pricing.minprice.cycle eq "quarterly"}
                                            {$LANG.orderpaymenttermquarterly}
                                        {elseif $product.pricing.minprice.cycle eq "semiannually"}
                                            {$LANG.orderpaymenttermsemiannually}
                                        {elseif $product.pricing.minprice.cycle eq "annually"}
                                            {$LANG.orderpaymenttermannually}
                                        {elseif $product.pricing.minprice.cycle eq "biennially"}
                                            {$LANG.orderpaymenttermbiennially}
                                        {elseif $product.pricing.minprice.cycle eq "triennially"}
                                            {$LANG.orderpaymenttermtriennially}
                                        {/if}
                                    </div>
                                    {if $product.pricing.minprice.setupFee}
                                        <div class="setup-fee">{$product.pricing.minprice.setupFee->toPrefixed()} {$LANG.ordersetupfee}</div>
                                    {/if}
                                {/if}
                            </div>
                            <div class="product-description">
                                {if $product.featuresdesc}
                                    <p class="product-desc-text" id="{$idPrefix}-description">
                                        {$product.featuresdesc}
                                    </p>
                                {/if}
                                {if $product.features}
                                    <ul class="product-features">
                                        {foreach $product.features as $feature => $value}
                                            <li class="feature-item" id="{$idPrefix}-feature{$value@iteration}">
                                                <i class="fas fa-check"></i>
                                                <span class="feature-value">{$value}</span>
                                                <span class="feature-name">{$feature}</span>
                                            </li>
                                        {/foreach}
                                    </ul>
                                {/if}
                            </div>
                            <div class="product-footer">
                                <a href="{$product.productUrl}" class="btn btn-order-now{if $isRecommended} btn-recommended{/if}" id="{$idPrefix}-order-button"{if $product.hasRecommendations} data-has-recommendations="1"{/if}>
                                    <i class="fas fa-shopping-cart"></i>
                                    {$LANG.ordernowbutton}
                                </a>
                            </div>
                        </div>
                    </div>
                    {if $product@iteration % 3 == 0}
                </div>
                <div class="row row-eq-height">
                    {/if}
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
</div>

{include file="orderforms/standard_cart/recommendations-modal.tpl"}
