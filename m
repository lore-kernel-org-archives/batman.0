Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Jan 2017 14:05:42 +0100
Message-ID: <1899098.CrQhkxgaNY@bentobox>
In-Reply-To: <1484884864-7315-1-git-send-email-jhaws@sdl.usu.edu>
References: <1484884864-7315-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2972737.mF0oC81SWp";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] alfred: IPv4 multicast distribution
	support.
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
Cc: Jonathan Haws <jhaws@sdl.usu.edu>

--nextPart2972737.mF0oC81SWp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 19. Januar 2017 21:01:04 CET Jonathan Haws wrote:
> @@ -273,10 +276,15 @@ static struct globals *alfred_init(int argc, char *argv[])
>  			return NULL;
>  		case 'p':
>  			sync_period = strtod(optarg, NULL);
> -			globals->sync_period.tv_sec = (int) sync_period;
> -			globals->sync_period.tv_nsec = (double) (sync_period - (int) sync_period) * 1e9;
> +			globals->sync_period.tv_sec = (int)sync_period;
> +			globals->sync_period.tv_nsec = (double)(sync_period - (int)sync_period) * 1e9;
>  			printf(" ** Setting sync interval to: %.9f seconds (%ld.%09ld)\n", sync_period, globals->sync_period.tv_sec, globals->sync_period.tv_nsec);
>  			break;

This doesn't seem to belong in this patch.

> +static int netsock_open4(struct interface *interface)
> +{
> +	int sock;
> +	int sock_mc;
> +	struct sockaddr_in sin4, sin_mc;
> +	struct ip_mreq mreq;
> +	struct ifreq ifr;
> +	int ret;
> +
> +	interface->netsock = -1;
> +	interface->netsock_mcast = -1;
> +
> +	sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
> +	if (sock  < 0) {
> +		perror("ipv4: can't open socket");
> +		return -1;
> +	}
> +
> +	sock_mc = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
> +	if (sock_mc  < 0) {
> +		perror("ipv4: can't open mc socket");
> +		return -1;
> +	}

You don't sock in this situation (on errors)?

> +	memset(&ifr, 0, sizeof(ifr));
> +	strncpy(ifr.ifr_name, interface->interface, IFNAMSIZ);
> +	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
> +	if (ioctl(sock_mc, SIOCGIFHWADDR, &ifr) == -1) {
> +		perror("ipv4: can't get MAC address");
> +		goto err4;

And now (see err4) you only close sock_mc? This applies to basically the rest
of the function. So I will skip it and not mention every place which looks
suspicious.

[....]
> +
> +	interface->netsock = sock;
> +	interface->netsock_mcast = sock_mc;
> +
> +	return 0;
> +err4:
> +	close(sock_mc);
> +	return -1;
> +}
> +

You only close sock_mc on errors but not sock?

And please chose something better [1] than err4.

Kind regards,
	Sven

[1] https://static.lwn.net/kerneldoc/process/coding-style.html#centralized-exiting-of-functions

--nextPart2972737.mF0oC81SWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliHUSYACgkQXYcKB8Em
e0aa9BAAtlIkBmzqxDRhNf68QXIw4A07WstcjnfS1Fuh/JhtdleWGputxxyk2OrN
7OQqLRzh2fU22HS9U8XuA4cec3VB9dvt8dMZ8I/yDS3bhYlqHp1bIR+rlrD7/fqh
T/fZ+eQbamTcT46ixdScpS1GEcuqpyuC2hA525S+C05B24zmGWMwz6PW6PpnynEp
rjqn/gnEzdZPsQIIOiDSoMhudVShNaFq+/ur37E+2KOXvMxCXcbIPgwOyd2m7RrQ
jDINr3W0khS0UxjMmzzaCAH2gR6cloVY76LJR67YeBghbPMHqQUi5RvStVHrqjXi
hQi7LXcsnYRoTljTXmtuQAen+XdmVZAI74WcvWC7ABIX0NMN3yR7A9k28iATVqYp
ALGZ6flNxVP9gIoF9NmOOYKwJuMvRBPxwsiuEa7g1uOf5hR3Pe9f1e2i6oT8kS+R
cyC6IQ4OesWyXIzmu96FR+RSU8wAikbGxRTTTZHydUffGRJW7UqN/ebguf+iPZYe
cH915vasyNmsq781/2yCpylpgA90+1WAF4KW8grOWtjiFhKcFwqiAZ3TFXV5oyhs
M7+U7jl0J3LMJDoEcTNEZoK2S8EbfzlJpG0zimHEMnMe/8wEzFpRKMTlbSjjyefs
LlM/XFkx7vlHN+iHjgcDyt8mTKRlLLl72TcuZldvKJ/OZieOU7U=
=xDN9
-----END PGP SIGNATURE-----

--nextPart2972737.mF0oC81SWp--

