From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 27 Jan 2009 11:06:53 +0100
References: <497CE6F6.7090504@francofon.fr>
	<003401c97fa8$cd3c1570$67b44050$@fr>
	<497EC25F.2060406@francofon.fr>
In-Reply-To: <497EC25F.2060406@francofon.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901271806.53826.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] problem with batman test
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Tuesday 27 January 2009 16:14:23 SoukoussMan wrote:
> Someone can help me to find which command is executed to add the
> 169.254.0.0/16 route to try to execute manually and look if i've a error ?

The command line would look like this:
ip route add 169.254.0.0/16 dev eth0

You can use logread to see the systems log messages.


Regards,
Marek

