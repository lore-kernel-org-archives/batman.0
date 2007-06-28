Message-ID: <46839CDF.30106@dd19.de>
Date: Thu, 28 Jun 2007 13:34:55 +0200
From: Alexander Morlang <alx@dd19.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] securing batman gateway
References: <2bda28cd0706260823h3c1e4d78m27f8eb9809e655cd@mail.gmail.com>
	<200706271208.19749.lindner_marek@yahoo.de>
In-Reply-To: <200706271208.19749.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Marek Lindner schrieb:
> Hi,
> 
> 
>> Batman has a tunnel with gateway but is it possible to secure it? In first
>> step only clients with proper credentials can start tunnel and in second
>> step tunnel is crypted.
> 
> I agree that this would be a good idea. Using the batman tunnels would be much 
> easier to set up than IPSec as everything is integrated. Besides that a 
> lightweight encryption could be implemented which even runs on weaker 
> machines.

What is lightweight encryption? Does lightweight means insecure? Is it
easier, because you are not familiar with IPSEC?

building unsecure crypto ist worse then having no crypto, it would be a
"sicherheitsimulation". building strong crypto is not easy, so many
failed to develop and implement it with more and better
cryptospecialists the the batman team has.

> 
> That feature is planned and a concept already exists. Nevertheless, the batman 
> developer team has a divided opinion about this idea. Some of us (inlucing 
> me) think that it a good opportunity to help spreading internet gateways 
> throughout a city wide mesh. The others fear that this could be the beginning 
> of the end of free mesh networks if we implement such control mechanisms.
> What do you think ? Why do you want this feature ?

Some batman developer once told me, that implementing/supporting service
discovery inside batman is a bad idea, as they want to have batman as
slim as possible.
how does integrating cryptotunnels in a routingprotocol does get conform
to that?

> 
> Btw: Does your vis server compile now ?
> 
> Regards,
> Marek


Greets, Alex
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGg5zfhx2RbV7T5aERAnhIAJ9SuEqQMAi6BjMwTZ2/KQ33ChpQfQCggVei
dI8wMB7ezWgPIS4Ko7kiMJo=
=bY0R
-----END PGP SIGNATURE-----
