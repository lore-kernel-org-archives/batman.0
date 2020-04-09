Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: working openwrt ibss configuration?
Date: Thu, 09 Apr 2020 07:54:18 +0200
Message-ID: <2428331.g3B3l9l1lY@bentobox>
In-Reply-To: <3d4b35cb-4a4a-13a3-90dc-bbdb26456145@coolheads.com>
References: <3d4b35cb-4a4a-13a3-90dc-bbdb26456145@coolheads.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1781114.JtcMaHvpFU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart1781114.JtcMaHvpFU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 8 April 2020 20:10:03 CEST Steve Newcomb wrote:
> Ben Greear suggested to me that I ask for help in figuring out how to 
> configure an adhoc/ibss based mesh.  I haven't been able to find an 
> example that's relevant.

I am guessing you mean OpenWrt configuration. Because you linked a 
OpenWrt routing commit below.

Take the wireless configuration from 
https://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config#Batman-adv-201300-till-20190-2 
and the network configuration from 
https://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config#Batman-adv-20190-3-and-newer

[...]
> My problem is that I have a bunch of wave-1 radios that, running under 
> ath10k-ct (Ben Greear's firmware), can support mesh networking only in 
> ibss mode (says Ben Greear).  I can use the non-CT firmware's 802.11s 
> implementation, but it's unreliable. I'm looking for a way around my 
> still-growing number of self-diagnosis-and-reboot hacks that are 
> necessary with nodes running the non-CT firmware.
> 
> I'm hoping that someone on this list is running batman-adv with 
> ibss/adhoc mode with a recent version of OpenWRT and will provide me 
> their appropriately-redacted working OpenWrt config files 
> (/etc/config/{network|wireless} as an example of something that is known 
> to work.

Uff. IBSS with Ben Greears firmware is... somewhat broken. I had fun with 
this a couple of weeks ago. Easiest way to break it (on Dakota) was to 
start an AP and IBSS interface at the same time - both will then top to 
beacon and only start to beacon again when you stop one of them. It was 
then decided just to stop using this firmware (and IBSS).

But maybe it still works for you. Maybe some of the Gluon users here can 
also provide some insides here because some of the communities used IBSS 
with ath10k-ct.

Kind regards,
	Sven
--nextPart1781114.JtcMaHvpFU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl6OuIoACgkQXYcKB8Em
e0anIg/+KOHX+FNVJL4VdxECNgA8Qi3670M6WkQdUoFsrWl5Z0UAkeqyIPLBe7UZ
K3NuRF3KgaL4pMTDGw1gWg6/d5IRGi4Jl//FgqHdGFDsvgq59IrepiAYLOltWP2E
IIAtfWSngj1BZZEJEndktmVzAK984EDtcorc/v0wBuX/rHLdatcaFRgvj3kuWitc
K71SND1TtP4dTuPWGiZeQBkLoMYB/StDITLoqxWpopt++LeKfp3/5/XUAS37BmbR
E+4C5pwDaIQBa8E+cZORMJtT0Ke15GOsX41TmKoS1OL8Zk14vgyBFN+knbdUhqmk
6rSP2KW8mIKksSdk6hgz20gtQHMKsPjnDdT2QQgFTaFoVjKv9rGTKzpSx4Nf/K6e
3zMlxkOrAzskDb8JAH7LtGKJ4voc8xteT1Fq+EFqCWWnZ3/rY6uwetwG4YH4H6r+
hdfKdwYZMMkLF8KP/nAVfm+I7mxUvN6N9V4/I3e3rbKysQEyiv08VaEYRGwsVB1s
zTLLltVLlv6UnZEGJdh2YwE1XQTSiSTz+IgJixI+5iFEi++3bCipSJOuBT4oGgjN
DXpbkF/eOjFVD1790vW8hg1DjgidBYwHqzByld2TnWxgAGgHYH8GuM9rfu2CF0VH
nPNclqsy/faTscKRX2aJ5Rg6MQQTUxRG9KQ4eFX9d6VdH/JKXP4=
=yiEZ
-----END PGP SIGNATURE-----

--nextPart1781114.JtcMaHvpFU--



