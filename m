Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 27 Mar 2016 15:40:11 +0800
Message-ID: <2639986.zmNa9CeUNU@voltaire>
In-Reply-To: <1457928344-30355-1-git-send-email-a@unstable.cc>
References: <1457928107-22710-1-git-send-email-a@unstable.cc>
 <1457928344-30355-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12800344.jgdSgAioKQ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batctl: tcpdump - add OGM2 and ELP
	parsing support
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
Cc: Antonio Quartulli <a@unstable.cc>, Antonio Quartulli <antonio.quartulli@open-mesh.com>

--nextPart12800344.jgdSgAioKQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, March 14, 2016 12:05:44 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio.quartulli@open-mesh.com>
> 
> These new packet types were introduced with B.A.T.M.A.N. V and
> required tcpdump parsing support.
> With this change it is now possible to properly read the content
> these packets by means of the batctl tdpcump command.
> 
> In order to reduce code duplication, the mechanism used
> to dump TVLV containers has been extracted and moved to a new
> function.
> 
> Signed-off-by: Antonio Quartulli <antonio.quartulli@open-mesh.com>
> ---
> 
> v2:
> - change through printing format from %.2f to %.1f
> 
> 
>  tcpdump.c | 164
> ++++++++++++++++++++++++++++++++++++++++++++------------------ tcpdump.h
> |  11 +++--
>  2 files changed, 123 insertions(+), 52 deletions(-)

Applied in revision 7075be1.

Thanks,
Marek

--nextPart12800344.jgdSgAioKQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW945bAAoJEFNVTo/uthzAjl0H/RunphJJusc25iyPTQHruqms
pWRWvL9nOH3vnbGCOG/HHyRZXu1gz+BzhpoU8NMPvwdPAk1ZJA6kqC0B/Me0Wy8p
Z7Er168qC6KafJkFi/pPYyo+u714VKBW9aK97cnt2VyK55upq0JBEXt1BKqywXrW
73Sz5IrRXqZWq6MMXROdlEGlkmIUgQmbsrOvrOvvI5bZ7qro+8l34kKDHeVP7UVv
LBHP3zTlswMxJUtf40t7+HTC9sCQIBf4l81BdfvX8l3k2GLOejSBE6tKCisBgqjH
BLD7BnIKZJ+pNM/tFqC5tI3T6ef+yKpMJRWZXjh1k+1C4YZHLdTi17W5en3eASE=
=Jrdh
-----END PGP SIGNATURE-----

--nextPart12800344.jgdSgAioKQ--

