Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 18 Sep 2018 14:44:15 +0200
Message-ID: <2298198.C0932aETW6@prime>
In-Reply-To: <DB5PR0301MB19446C9E9FF81AA7B6610635E51E0@DB5PR0301MB1944.eurprd03.prod.outlook.com>
References: <DB5PR0301MB1944DC35135E3B7AFEDF9596E5040@DB5PR0301MB1944.eurprd03.prod.outlook.com>
 <3281209.XlqulP57tX@prime>
 <DB5PR0301MB19446C9E9FF81AA7B6610635E51E0@DB5PR0301MB1944.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2178816.Hu2DfJSyeF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] R: R:  Network loops on gateways join
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "Francesco Salvatore [fabbricadigitale]" <f.salvatore@fabbricadigitale.it>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart2178816.Hu2DfJSyeF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Francesco,

On Monday, September 17, 2018 3:44:53 PM CEST Francesco Salvatore 
[fabbricadigitale] wrote:
> > 
> > LAN to mesh.
> > 
> > That certainly looks like an announce frame. Do you see any other frames
> 
> in
> 
> > between, like claim frames?
> > 
> > Announces are also sent after a couple of claim frames upon a request
> > (check batadv_bla_answer_request). We actually had a bug where
> > inconsistencies among the BLA tables could happen, but that was fixed
> > before 2017.3 ...
> 
> BLA traffic seems regular. This
> (https://mega.nz/#!9ZkmharA!S9mFxvpnnnseu_l8H7MPfoZ7X1Ef0lNrJLVQOpgTg4w) is
> a dump of  the broadcast traffic captured from LAN ports of four gateway (on
> two separate VLANs). As you can see loop starts at packet 2660.
> The four gateways are:
> .	00:0f:00:68:97:e4 (Bridge IP 10.140.0.61)
> .	00:0f:00:68:9f:4b (Bridge IP 10.140.0.17)
> .	00:0f:00:68:96:66 (Bridge IP 10.140.16.19)
> .	00:0f:00:55:3c:dc (Bridge IP 10.140.16.61)

Hmm. There are already other packets looping in the beginning. There are some 
ARP requests which are repeated 4 times (packets 39 and following). Are those 
MACs on the network?

I don't really know what's going on from staring on this dump. You may want to 
remove components which are not vital and check if it's still happening. For 
example, you may want to connect the Raspis with a simple switch first (if you 
don't already do that). But the loop is already present before that announce 
loop, it seems - BLA would normally avoid repetitions.

> 
> > > > BATMAN has a grace period to allow broadcasts from the LAN only
> > > > after 1 minute of operation. This is done to make sure that the mesh
> > > > is properly established and other gateways and their claims are
> > > > detected before
> > > 
> > > traffic is
> > > 
> > > > allowed on it, at least potentially looping traffic. Therefore, you
> > > > should
> > > 
> > > make
> > > 
> > > > sure (e.g. in your firmware or setup scripts) that the LAN is
> > > > operational
> > > 
> > > once
> > > 
> > > > batman is brought op.
> > > > 
> > > > If the mesh isn't fully established or it's actually split due to
> > > 
> > > different
> > > 
> > > > channels or similar, then you may run in an unresolved limitation of
> 
> BLA:
> > > > https://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-> >
> > > > avoidance-II#Limitations
> > > > 
> > > > For this reason we have the loop detect packets. If a loop is
> > > > detected, an uevent is sent to userspace, and the firmware should
> > > > react appropiately,
> > > 
> > > e.g.
> > > 
> > > > by shutting down batman-adv.
> > > 
> > > We start gateways with this script placed in rc.local
> > > 
> > > sudo pkill wpa_supplicant
> > > sudo modprobe batman-adv
> > > sudo ip link set wlan0 down
> > > sleep 2s
> > > sudo iwconfig wlan0  mode ad-hoc
> > > sudo iwconfig wlan0 essid mesh-network sudo iwconfig wlan0 ap any sudo
> > > iwconfig wlan0 channel 44 sudo ip link set wlan0 up sudo batctl if add
> > > wlan0 sleep 1s sudo ip addr flush dev eth0 sudo ip link add name
> > > br-lan type bridge sudo ip link set dev eth0 master br-lan sudo ip
> > > link set dev bat0 master br-lan sudo ip link set up dev br-lan sudo
> > > batctl bl 1 sudo batctl gw server
> > > 
> > > 
> > > As far as I can see the bridge interface gets IP/connectivity from LAN
> > > a few seconds after the script quits. Are there steps correct or there
> > > are possible timing issues?
> > > We're using the same essid/channel for all originators
> > 
> > It would be good to do "batctl bl 1" before adding bat0 to the bridge,
> > otherwise you are not protected. Other than that, it looks fine to me.
> 
> Am I wrong or "batctl bl 1" is redundant? As far as I can see, according to
> batctl, BLA is turned on by default in gw mode.

Hm you are right, it's probably enabled by default. That should be independent 
of the gateway feature though.

Cheers,
     Simon

--nextPart2178816.Hu2DfJSyeF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlug8x8ACgkQoSvjmEKS
nqH01A//eu/m2C0GHba0zSbbtrJgUS2q3m+2R8Q5anWWXBm7Fr4WLptRJvDzgln/
1h/ya+WYw5TEZSc6KFbQqNAOlVT3AGjC43oZXM1xN6DT/D8nDvheDwxBK8ev3lSU
lYXOfVysciTzV2oXvm6KbUEwINzq0JIvoVhEkovHvv3A9oZHC0PbfLeSnaLch2c1
/0Q/1orZA4tpOSG/sQfK2+RFVv8T0PkPIs0LU87vQqM3CVGF9rL3TKjlE8yvMsE6
eLk7DIVLAdI9lF1jz+Mmcdf3AtoLNU+Z/Vdqlsv2Nri4ygM858dCZMot+mS6SGbZ
ssfeqg0ZT10uZafq4m2T5raKWj5aH9qMpVY8FrVtnMXNbnuc56nlzE1hAQhp6CBU
8rmb884T+VeB1Exo+Oo+aP4bi055UJCQnq6zATQgOd+M9R/LjQJR6CHnSrOCoFdB
XhTwbTT5Jw++zuDtlXn7mdNbeTPyiicVG9DniuOTmDWsgzFrksjq69V88d06PmIi
/diGURCg2MVazJqMbsC28NvOJIj24yFsT9oP7otK1b8GSJx8ULAO+SC+E1EUazSI
cNaFwPPBnoOu2ZPXZBXNJ4KnXrA/qy5JvttbfEvJAorjGPEpDmx3c7TZuobfJkOi
iQM09dn0VuZN/O9ZE5cEeEJTtQcqVRfz4HTvJE33cyxKZcrnjG8=
=3EZe
-----END PGP SIGNATURE-----

--nextPart2178816.Hu2DfJSyeF--

