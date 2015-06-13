Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 14 Jun 2015 00:21 +0800
Message-ID: <5848467.YBQmR7qBth@voltaire>
In-Reply-To: <557C4EF0.3060204@rund.freifunk.net>
References: <557C4EF0.3060204@rund.freifunk.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3753264.XgddEPVMqQ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] openwrt config changes when upgrading from
	2014-4 to 2015-0 ?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart3753264.XgddEPVMqQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, June 13, 2015 17:40:32 Ufo wrote:
> thank you for upgrading batman-adv inside openwrt trunk to 2015-0
> 
> im testing new version (yesterdays openwrt trunk) but have problems:
> the bridge (br-mesh12) with bat-interface and wifi-vAP isnt complete,
> the bat-interface is missing
> the "wifi" command also doesnt repair that
> 
> but, when i delete vlan-setting (for interface, where batman-adv is
> running on) problems are gone.
> 
> maybe config for openwrt/batman-adv has changed, or some of our settings
> are outdated and now obsolete?
> 
>  ufo
> 
> p.s. with 10 days old openwrt trunk (and batman-adv 2014-4) the problem
> doesnt appear

The batman-adv uci config has not changed one bit. You can check the package 
diff: https://github.com/openwrt-routing/packages/commit/4dc2c500ffde0e248dbc83e5bd904ec0c9af0c42

Can you try the '10 days older openwrt trunk' with batman-adv 2015.0 ? That 
way you can rule out batman-adv.

Cheers,
Marek

--nextPart3753264.XgddEPVMqQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVfFhwAAoJEFNVTo/uthzAP4wIAJhqnID9t0VcKR8biKLqTrz4
JFiCHFJgjOhg83veKc147S5018zWc/5uKvfFnYBu8u8v2eM2e41s6Eix/D7yGMT+
RexX0W3KNLXrTnIDee2+xWsCJ49CKqKDKbL3/7w4vKg9UF4HP5WWtvbqBL9jkxXJ
9XPtQ6m9ncmsqoF5My5XTogGS0mg1pYMuAC4xCyDENksTroCsifjzRyGqojWM9Q8
VV3yLabXqi+HKsYi0VXuaT4bfYWxzRzKMkRqOL355GDcpVEAFeQDOQR4HMt0KPBt
vXwz9Ca/4zZCZjl7JSXDe9G9rcWVrppCQWohHDXk2KC72Z2H8yT7lGtfQ88NlxI=
=lJPl
-----END PGP SIGNATURE-----

--nextPart3753264.XgddEPVMqQ--

