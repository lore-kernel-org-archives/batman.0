From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Split SOURCE_VERSION in RELEASE- AND
	EXTRA_VERSION
Date: Sun, 28 Dec 2008 15:24:57 +0100
References: <1230469532-24319-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1230469532-24319-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812281525.01252.lindner_marek@yahoo.de>
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


Hello Sven,

> Afterwards the development branch should change the RELEASE_VERSION to
> the upcoming version number and the EXTRA_VERSION to a string which
> informs the user that it is "unstable" and in development. This could be
> for example "-dev", "-pre-alpha", "-beta" or "-rc1".

I like your patch a lot. It could solve a nasty little problem that always 
tends to be forgotten.  :-)

Unfortunately, our compile farm which feeds the package repository extracts 
the SOURCE_VERSION from batman.h to generate the package name. Unless we 
rewrite the compile scripts to extract both defines we can't apply your patch 
as-is. This rewrite is not as painless as it could be. Certainly, at some 
point we want to touch the scripts to optimize the speed but that wasn't on 
our agenda right now. 

Do you see alternatives which allow us to reuse the existing compile farm and 
have the functionality you implemented ?

Regards,
Marek

