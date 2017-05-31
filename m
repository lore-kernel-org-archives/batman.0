Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 31 May 2017 17:24:45 +0200
Message-ID: <2339368.gV653yJKBs@prime>
In-Reply-To: <4690435.IOLn72U8Ez@bentobox>
References: <4690435.IOLn72U8Ez@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1509797.yvO0LgVZi9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/5] alfred: TQ query optimizations
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
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>

--nextPart1509797.yvO0LgVZi9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, May 24, 2017 12:31:28 PM CEST Sven Eckelmann wrote:
> Hi,
> 
> alfred uses the TQ from batman-adv to find its best alfred neighbor. This
> best neighbor information is used by slave servers to request/publish data.
> 
> This is done for each server announcement packet by:
> 
>  * requesting the global translation table (netlink or debugfs) and then
>    searching in it for the MAC address of the detected alfred server to find
> its originator address
>  * requesting the originator table (netlink or debugfs) and then searching
> it it for the originator address of the detected alfred server to find its
> TQ value
> 
> This was previously done whenever a new announcement packet received by
> alfred. We've observed that this can be a problem on networks with a lot of
> master servers (~100) which can see each other, large translation tables and
> slow CPUs. alfred still worked but the CPU load by alfred was rather high
> (~20% on an 560MHz AR9344).
> 
> The idea is now to avoid this lookup for master servers. And (for slave
> servers) to process all servers at once. This is done before the wants to
> push its local data to a master server in an sync interval.
> 
> The process which was described earlier was now changed to:
> 
>  * requesting the global translation table (netlink or debugfs) and then put
> MAC address and corresponding originator address in tg hash
>  * requesting the originator table (netlink or debugfs) and then put
>    originator address and corresponding TQ value orig hash
>  * got through all servers:
>    - search in tg hash for for the MAC address of the alfred server to find
>    its originator address
>    - search in orig hash for for the originator address of the alfred server
> to find its TQ value
> 
> These changes reduced the load on the previously mentioned devices
> significantly.

I've applied this patch series with some fixes in patch 4 and 5 regarding the 
hash initialization.

Thank you,
     Simon
--nextPart1509797.yvO0LgVZi9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlku4D0ACgkQoSvjmEKS
nqGxhg//VGEJpM2qKydudxeX7IfPODBUjgZsTTBZBYnzRpkq+2wpTY7X74lJKGL/
XbGoRaZn+UGIt+Bf0d94DTAXBJSuPHWIV3I9sPVUCTU9uV9zeJVc9bQY92UY5Inm
yVIcMUeFrMkwN6viMYEn1oS3sRJEg8vXh6lA40oAJ9tU2Z+GIXS/3eaby3Dv+x/+
hUFTQ8QnJ32905rAAKFvk6dmhYVfoRBkhQdqT2CH25tPpR+cvtGFljjg6dUSC7IP
z93ojouUN5mcMa+OEJeggSq1NcNuT531ZQ9b8f+OlolGc2rbTPwZ1F+VFAyYsP4K
ZBWbrNeIjmTewcBUXJq69TGUBAIGD4N14uxWX0GLZG/ssq3mNmhItLWnq9IYlm02
U8R+8QpOAIDoo6WwsyhG5dIcARtLP2BnHAzbH4MOj0dET1icYUP7KOPimRPrGMus
z+Dmdx0ecUowbi2PgSQxfTC0ccfnHxRnPQ9jt6ZiM+x5ggev9HVoTVkBvas671pa
m3c/oXGpJ3MVdQRmw7FxC/kxblndE2imzk0UyWEBvjJ5uIk8nknNI/phGyQJ3xEj
gdt9O6tEjvObSb+mijFQNwWixcjg4lfm8kgCKYDMy9kvGn3nZJEQF1bWQtwIDNZd
G/PKGyODCQ8RsYbRJKEoM4SSridG6bimQ0XUPAGQnWp5LbOBRs4=
=4w0z
-----END PGP SIGNATURE-----

--nextPart1509797.yvO0LgVZi9--

