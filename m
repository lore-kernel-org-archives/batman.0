Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 03 May 2016 14:54:26 +0200
Message-ID: <3986955.uBauJeRErD@bentobox>
In-Reply-To: <20160503124719.GB16952@lunn.ch>
References: <1462222618-29761-1-git-send-email-andrew@lunn.ch>
 <1679465.5nkEMONaEr@bentobox> <20160503124719.GB16952@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3543170.KKqN2PZSd6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: Use netlink to replace some of
	debugfs
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3543170.KKqN2PZSd6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 03 May 2016 14:47:19 Andrew Lunn wrote:
> On Tue, May 03, 2016 at 02:26:34PM +0200, Sven Eckelmann wrote:
> > On Tuesday 03 May 2016 14:20:46 Andrew Lunn wrote:
> > [...]
> > > There does not seem to be a way to say that BATADV_ATTR_VERSION is
> > > also an NLA_STRING.
> > 
> > Please check "policy" in the link I gave you.
> 
> I did. And i still don't get how you can check the type.
> 
>   Andrew

   struct nla_policy {
            uint16_t        type;
            uint16_t        minlen;
            uint16_t        maxlen;
   };

there is an entry for type, minlen and maxlen. The type member is to check for
the type. Here is an example how to check the type from batctl:

    static struct nla_policy info_data_link_policy[IFLA_MAX + 1] = {
    	[IFLA_LINKINFO]	= { .type = NLA_NESTED },
	    [IFLA_LINK]	= { .type = NLA_U32 },
    };
    [...]
    	ret = nlmsg_parse(n, sizeof(struct ifinfomsg), tb, IFLA_MAX,
    			  info_data_link_policy);

Kind regards,
	Sven
--nextPart3543170.KKqN2PZSd6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXKJ+CAAoJEF2HCgfBJntGbLIQAIZ9eKZrjfnfO1XbPXxxrIm7
S5ijo8+aeiwvlo1Cvo96rsQbjmTU83s7oUo1y4wJI9dY6znNOgAmfLy3YhOaH2KQ
5zgbILp+FANld5kmgH+ex7qrqc7SclWhnHJxp+MHSbk2jgaI6AjqYXdxEoZwRSRA
c0mpVVhg08okpl0MwDAFueNbtpidONkEvegmah1IjNiqXW4kSvFmYGkZp1vpqgH7
IsyJ73RbcYj4BQ9b8R2KWDVlKI0VIfIZD1odfpJV9jif3D4OLQSRxzO7pIZLSarg
F7AVfE8/iiBqdoK5Z7IVeHHMyq1iwGMYdOxXZCp7aa+yu9oyTnwQeTa6LolQGjCj
W5kvJIqSUvB4n2u9gKnL3i+lP6yXaXci7Cw7uBJ6lyk+KgcSkrdVAHp5s6ZXzwS0
Ptu3gz8mv87m+TakX1NQKYajVlpRNAdjCI2/zwkaajn3puUTL4M1IALSHa9IlWyW
fUUcxtOu+iw7unG1tWQXZYF8umUs4eL1QP46rdz58q+0CarFn32MpfWWwCC7t1/J
EO9BdYP622fkTe2bFm1IjmwAOStDovve7yQeM9P3RzONdGPzIKJltQn1rCH96SQf
WXdZX6VjF5uYst/Yt+VswIjVDaZKfDxHJROoESERrDIoQr7TI/12qeVrZryqjYiV
xj3vJtWDyaVnySg912O+
=5IPP
-----END PGP SIGNATURE-----

--nextPart3543170.KKqN2PZSd6--

