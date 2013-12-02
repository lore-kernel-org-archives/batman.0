Return-Path: <antonio@meshcoding.com>
Message-ID: <529C8226.2040000@meshcoding.com>
Date: Mon, 02 Dec 2013 13:50:46 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <20131130191553.GA16735@n2100.arm.linux.org.uk>
 <529A46C4.9090906@meshcoding.com>
 <20131130230518.GC16735@n2100.arm.linux.org.uk>
 <529A8276.9060002@meshcoding.com> <529B47AA.8060403@meshcoding.com>
 <20131201171309.GD16735@n2100.arm.linux.org.uk>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7451@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7451@saturn3.aculab.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] Fix ARM BUILD_BUG_ON() errors
	withbatman-adv
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
To: David Laight <David.Laight@ACULAB.COM>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: netdev@vger.kernel.org, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, David Miller <davem@davemloft.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/12/13 11:24, David Laight wrote:
> ...
>> The only solutions are: use the GCC packed attribute, redesign
>> the structures...
> 
> It is probably enough to mark the inner structure containing the
> three byte fields 'packed'. Marking it aligned(1) might also have
> the desired effect. The outer structure should then be ok. But
> would need to use a specially named attribute so it doesn't get
> removed.

This may work with the structures I reported in a previous email, but
it is not a good solution for us because we have other more complex
substructs that cannot be packed that way.

I think we will simply duplicate the members and avoid substructs in
our packets.

- -- 
Antonio Quartulli
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlKcgiYACgkQpGgxIkP9cwfeeQCfef0xDfD2TucJBhzoTmDfwA29
Oc4An3Etz3USDC0cf/+R+Gyx8LEtpq16
=XZn5
-----END PGP SIGNATURE-----
