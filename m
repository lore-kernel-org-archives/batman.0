Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 11 Apr 2016 23:59:36 +0800
Message-ID: <1530605.2eAfRak7fa@voltaire>
In-Reply-To: <1457777579-28982-1-git-send-email-sven@narfation.org>
References: <1457777579-28982-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2604592.JYpf5E4J5x";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: fix DAT candidate
	selection (must use vid)
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart2604592.JYpf5E4J5x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 12, 2016 11:12:59 Sven Eckelmann wrote:
> From: Antonio Quartulli <a@unstable.cc>
> 
> Now that DAT is VLAN aware, it must use the VID when
> computing the DHT address of the candidate nodes where
> an entry is going to be stored/retrieved.
> 
> Fixes: 3e26722bc9f2 ("batman-adv: make the Distributed ARP Table vlan
> aware") Signed-off-by: Antonio Quartulli <a@unstable.cc>
> [sven@narfation.org: fix conflicts with current version]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - rebased patch
>  - added kernel-doc for new parameters
> 
> Patch was resurrected from https://patchwork.open-mesh.org/patch/3427/
> 
> I've requested an rebased version at
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014636.html
> but done it myself because it was rather trivial.
> ---
>  net/batman-adv/distributed-arp-table.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Applied in revision 22d98bd.

Thanks,
Marek

--nextPart2604592.JYpf5E4J5x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXC8noAAoJEFNVTo/uthzAEs4IAIMEO8zwgaosJxJAsd6yv76s
x297iXtxWE/+YkOrDtpi1dDjwOhuB4eRczhvZ98hICDKqGJ0m9hf8LAdtSVr7IkV
ami4TV74bEP970HZ/2HBXVweEeyxvNNxg45zok9E96IlcuDJmaN0Ioz2g+Uid/rV
8KqPDM4XWBaeNK8HO91Ib6cKjAeXD6QWw3EuchxRT+wD9LFTXBRwWY/ml4/bSn3W
TRV9bMMPMz4+bmsVqdl9s7mGpt1SrMuaXcr7pl8UkkWGuzX3sWB8mCRZxq2jAzaB
7jez3iAHuWE4yUpcTU1fkd8H6Qv6aYoxxrA9/haAOyMBY8Ucd7NiWB8lf80hgoE=
=jLUO
-----END PGP SIGNATURE-----

--nextPart2604592.JYpf5E4J5x--

