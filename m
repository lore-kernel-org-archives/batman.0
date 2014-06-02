Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 03 Jun 2014 00:20:59 +0800
Message-ID: <1660663.6gT1Y85jok@diderot>
In-Reply-To: <1400489521-22006-1-git-send-email-antonio@meshcoding.com>
References: <1400489521-22006-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart233647960.xgOPJJP7ON";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] openwrt-feed-batman-adv: enable
	batadv_vlan protocol
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart233647960.xgOPJJP7ON
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 19 May 2014 10:52:01 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> This protocol can be used to change VLAN-specific settings
> of a batman-adv soft-interface.
> At the moment only ap_isolation is available, but new ones
> can be easily added as soon as batman-adv get to support more.
> 
> Interface configuration example:
> 
> config interface 'bat0vlan1'
> 	option protocol 'batadv_vlan'
> 	option ifname 'bat0.1'
> 	option ap_isolation '1'

Applied in revision 26284d3.

How about moving this documentation to the OpenWrt config page in our wiki ?
http://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config

Thanks,
Marek

--nextPart233647960.xgOPJJP7ON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTjKRwAAoJEFNVTo/uthzAVNwIAJVNdrOJiVkP/O5anQX5+10J
QHJAkrWha6OyFpP7pEupPYI4Rb5b37C/MpMzvUAAJjYcuF/3bzRK2gISOFc6mHcH
00eRHvtuu4Ts8TcvtTL0KsgrYd8PnxqiU0Q+gyQt0Qay51lGbRgWabYvn8zH0Ia8
iT4uPC9KTXA/GZYV55Gfa88z0V23keMnW2UErBuhyH+PZKxlvcLkronyend23mFW
DY8u2K0DfhpGTtKPGpV6JwwzoqL6zSFK1nVhG1fglrNEYEQ8PZ5TOOVkYDItrT+1
r9Ojg3KPedVh0JM+6MxmMSGckxGxd3UWZoT/lkSYqCvOPQMuLl+N0LRhaaDXv50=
=zeMe
-----END PGP SIGNATURE-----

--nextPart233647960.xgOPJJP7ON--

