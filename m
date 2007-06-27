From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] securing batman gateway
Date: Wed, 27 Jun 2007 12:08:19 +0200
References: <2bda28cd0706260823h3c1e4d78m27f8eb9809e655cd@mail.gmail.com>
In-Reply-To: <2bda28cd0706260823h3c1e4d78m27f8eb9809e655cd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706271208.19749.lindner_marek@yahoo.de>
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


Hi,


> Batman has a tunnel with gateway but is it possible to secure it? In first
> step only clients with proper credentials can start tunnel and in second
> step tunnel is crypted.

I agree that this would be a good idea. Using the batman tunnels would be much 
easier to set up than IPSec as everything is integrated. Besides that a 
lightweight encryption could be implemented which even runs on weaker 
machines.

That feature is planned and a concept already exists. Nevertheless, the batman 
developer team has a divided opinion about this idea. Some of us (inlucing 
me) think that it a good opportunity to help spreading internet gateways 
throughout a city wide mesh. The others fear that this could be the beginning 
of the end of free mesh networks if we implement such control mechanisms.
What do you think ? Why do you want this feature ?

Btw: Does your vis server compile now ?

Regards,
Marek
