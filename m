Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 15 Feb 2016 09:50:18 +0100
Message-ID: <10971950.7jXMiP8m2i@prime>
In-Reply-To: <OF514CE6A6.70ACFF1A-ONC1257F57.004BE44C-C1257F57.004C213B@phoenixcontact.com>
References: <OF514CE6A6.70ACFF1A-ONC1257F57.004BE44C-C1257F57.004C213B@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1531786.ALK9gtfh0f";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: Prevent mutliple ARP
	replies sent by gateways in bla setups with dat enabled
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1531786.ALK9gtfh0f
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday 12 February 2016 14:51:32 Andreas Pape wrote:
> From 2b90abdf53e9ab09d9acfd141c7225de1ae16719 Mon Sep 17 00:00:00 2001
> From: Andreas Pape <apape@phoenixcontact.com>
> Date: Fri, 12 Feb 2016 10:05:57 +0100
> Subject: [PATCH 1/4] batman-adv: Prevent mutliple ARP replies sent by
> gateways in bla setups with dat enabled
> 
> This patch shall make sure that only the backbone gw which has claimed the
> remote
> destination for the ARP request answers the ARP request directly if the
> MAC address
> is known due to the local DAT table. This prevents multiple ARP replies in
> a common
> backbone if more than one gateway already knows the remote mac searched
> for in the
> ARP request.

This patch looks good in general. I can not apply it though, please check the 
links that Sven posted how to set up your mail client to send patches. Also, 
the commit message seems to have too long lines. Usually your git client 
should limit those to ~72 characters per line (I'm not sure about the actual 
limit)

> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> ---
>  net/batman-adv/bridge_loop_avoidance.c |   58
> ++++++++++++++++++++++++++++++++
>  net/batman-adv/bridge_loop_avoidance.h |    6 +++
>  net/batman-adv/distributed-arp-table.c |   14 ++++++++
>  3 files changed, 78 insertions(+), 0 deletions(-)
> 
> diff --git a/net/batman-adv/bridge_loop_avoidance.c
> b/net/batman-adv/bridge_loop_avoidance.c
> index 0a6c8b8..c70363d 100644
> --- a/net/batman-adv/bridge_loop_avoidance.c
> +++ b/net/batman-adv/bridge_loop_avoidance.c
> @@ -1906,3 +1906,61 @@ out:
>                 batadv_hardif_put(primary_if);
>         return 0;
>  }
> +
> +/**
> + * batadv_check_local_claim

You should put a short description here, like

batadv_check_local_claim - check if the address has been claimed by the local 
backbone

> + * @bat_priv: the bat priv with all the soft interface information
> + * @addr: mac address of which the claim status is checked
> + * @vid: the VLAN ID
> + *
> + * batadv_check_local_claim:

Please remove the repetition of the function name

> + * addr is checked if this address is claimed by the local device itself.
> + * If the address is not claimed at all, claim it.
> + * returns true if bla is disabled or the mac is claimed by the device
> + * returns false if the device addr is already claimed by another gateway
> + */

Should put Return: and then describe the return values. Please check the other 
functions for reference.

kerneldoc is parsed automatically and must therefore be in the right format.

> +bool batadv_bla_check_local_claim(struct batadv_priv *bat_priv, uint8_t
> *addr, unsigned short vid)
> +{
> +       struct batadv_bla_claim search_claim;
> +       struct batadv_bla_claim *claim = NULL;
> +       struct batadv_hard_iface *primary_if = NULL;
> +       bool ret = true;
> +
> +       if (atomic_read(&bat_priv->bridge_loop_avoidance)) {

You can save an intendation by doing a return here immediately

> +
> +               primary_if = batadv_primary_if_get_selected(bat_priv);
> +               if (!primary_if)
> +                       return ret;

I'd prefer a goto here. If we have other stuff to clean up when we change this 
function later, we may forget that this is not done because we used return 
here.

> +
> +               /* First look if the mac address is claimed */
> +               ether_addr_copy(search_claim.addr, addr);
> +               search_claim.vid = vid;
> +
> +               claim = batadv_claim_hash_find(bat_priv,
> +                                 &search_claim);
> +
> +               /* If there is a claim and we are not owner of the claim,
> +                * return false;
> +                */
> +               if (claim) {
> +                       if (!batadv_compare_eth(claim->backbone_gw->orig,
> primary_if->net_dev->dev_addr)) {
> +                               ret = false;
> +                       }

braces not needed

> +               } else {
> +                       /* If there is no claim, claim the device */
> +                       batadv_dbg(BATADV_DBG_BLA, bat_priv, "No claim
> found for %pM. Claim mac for us.\n",
> +                                       search_claim.addr);

Maybe put something in the debug code where this was called from? This looks 
like a very generic claim message.

> +
> +                       batadv_handle_claim(bat_priv,
> +                                                      primary_if,
> + primary_if->net_dev->dev_addr, addr,
> +                                                      vid);

I wonder if we should rename the function somehow, since actively claiming 
goes beyond "just checking". Maybe handle_local_claim.?

Also, primary_if can go on the line above I guess.

Cheers,
     Simon
--nextPart1531786.ALK9gtfh0f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWwZFLAAoJEKEr45hCkp6hRfEQANSV9z5nE0SfEi1qxY1ih48t
C6WiCwADTfmVIBw5htLYgNQXZr9LnfZJ9XPMnVLDiAFMYyH7ZypRJWSZ2Si7sVwt
nEe9L94vIxU6nERlhOTfAxvvfqPQ4f7TVdHS4Ua43XHG9WjDuBGHXJTwbehsi5yf
wg3zPDCbbc5v/KHUrJbib/bm4zDzWy5cJnOlb3F0WevlG8sxi+TvNqE6teiHDmxB
EZlqG9PCWv2NFhhJAxV4dfI/9uhm9CpV0yAdLPC+YpgacdVZF4h+93bLmvifmIFl
fzH4CiN3OeTdqDkgfFSmApRvS0BzMxyDlXYum1Z2MUZ/82qCymTY0v7xGn9J90AP
GSM08ykNIsbWrCK3RzAXpmbBwPKOvVQP+MtHbj7COcSjiS1/C1VfbPTEvHeUBQd0
uOLUx/Ou9bUGqWZpbwj9BTlE03m6Zn6mkQeQNp4nidE6fqKcHJmntTvpHJkFcK0v
HjZeDTetBGZ2dSx7HxzfreYt85ECTifDKTGQUDVS4eHW50lc8Go4bABMexUNOyi9
bpI2KUMiGvZ0ev0ZKJYNPsgkk3Hfh6m01rhedSHHdGyj6gMWvgl0gZ5blY9t74/v
nQwXs8jSrtintJ/tUIcOMuF8CW1QeU8vyhOtSlkMNZeMLprLA3Jx5ySq0PE6VOz2
Nt0+se7ZHfjX77BUmnoY
=bp03
-----END PGP SIGNATURE-----

--nextPart1531786.ALK9gtfh0f--

