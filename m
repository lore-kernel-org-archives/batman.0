Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 25 Jan 2019 09:23:42 +0100
Message-ID: <2843714.oyMTxGbNKy@bentobox>
In-Reply-To: <1DC40B07CD6EC041A66726C271A73AE68CFA842A@IRSMSX108.ger.corp.intel.com>
References: <20190125080205.10594-1-sven@narfation.org>
 <1DC40B07CD6EC041A66726C271A73AE68CFA842A@IRSMSX108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7411239.his8t7OFxK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: release station info
 tidstats
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "Berg, Johannes" <johannes.berg@intel.com>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, Felix Fietkau <nbd@nbd.name>, Arend van Spriel <aspriel@gmail.com>

--nextPart7411239.his8t7OFxK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 25 January 2019 08.16.46 CET Berg, Johannes wrote:
> Huh, sorry about that.
> 
> > From: Felix Fietkau <nbd@nbd.name>
> 
> If Felix had nothing to do with the patch, why would you pretend otherwise?

This is what he has dropped and Martin Weinelt forwarded to us:
http://nbd.name/batman-adv-memleak.patch

So just the net/batman-adv/bat_v_elp.c part without anything else.

> You need two patches - one for backports, this part:
> 
> >  compat-include/net/cfg80211.h | 7 +++++++

This is not for backports [0] - this is for batman-adv.git [1]

> And for mainline, this part:
> 
> >  net/batman-adv/bat_v_elp.c    | 3 +++
> 
> So send the two separate patches to the two separate projects, and that's it?

The upstream patch (for David) is just stripped from the compat-include part.

Kind regards,
	Sven

[0] https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/
[1] https://git.open-mesh.org/batman-adv.git
[2] https://git.open-mesh.org/linux-merge.git/commit/7d652669b61d702c6e62a39579d17f6881670ab6
--nextPart7411239.his8t7OFxK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxKx44ACgkQXYcKB8Em
e0ZJfhAAmdAcmLTQeP38LP3FelESUjbe+OMSOPDw8sYIYKD5nh9DzRPOkKIbEZUC
JE1BlJv11Y/aW+nRB/BOsyRe8kedP7Jh9qJ1EjJtEk4+lqBaNT89lxl5kGiEMZDb
zqRa79kYLyEIy+fr/RJ6aoWvcH8aMEGavYNZC837Ixio/AK5pv1/AyQpxYFiLMg4
v0nDng0NPCl8jWbEkzSedbfM8zxdFGhBScHF/lJXIvBLPemxlqemeGkEH9G9aYo9
pHIFMI+h/3blJTzgJunfNlTPnY4v7yCKR+y5qj3TZjFJLoR5gaDbwCs+iC3iHpEH
WRvkLO/BsWQCcbS77mzUcUnF8nTDMUY1CxIECLguk3E2g2j9+NKx1m3uOMG14d82
cqRk+H/Z25EgJrHP+s/cFSPLeIPqVWqnpgab7GpM1cQMqUypSocAczQ+VvrK6upT
Op0tY9pYFeALMH7furecb6dp9flS4rf6So4PLZZHOJXyoU7zfvgefg3BvQLLUS5Y
oBS2bvHP61hLjIOVNwC/PBjjeKWt6w6OsiUvfAFQB7FCWIsVfMzrH3ExMWYj5oUM
urnpbvhZXPmnMbEl6WVnrciQ7tJZ0lC84UDM3C7ZZs5O7geXfyxI6f8ekNIug7VH
sv1jrLh9y1hJXjOF6uIZlS4DvBfuz3ftCtfeQ9H0gxwAHb22nUY=
=HKRm
-----END PGP SIGNATURE-----

--nextPart7411239.his8t7OFxK--

