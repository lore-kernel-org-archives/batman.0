From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 12 Sep 2008 10:33:27 +0800
References: <20080911135327.GA21671@sven-desktop.lazhur.ath.cx>
In-Reply-To: <20080911135327.GA21671@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809121033.27804.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Remove batgat proc entries correctly
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

On Thursday, 11. September 2008 21:53:27 Sven Eckelmann wrote:
> We must remove the /proc/net/batgat/clients file and /proc/net/batgat dir
> correctly or otherwise we will get a oops when someone tries to access the
> file. If we do not remove the directory it is possible that more then one
> batgat entry appears inside of /proc/net/

Your patches look very good. Nice catch !
Simon already applied them. 

Thanks,
Marek
