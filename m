From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 1 Apr 2009 02:26:08 +0800
References: <200903251044.05666.lindner_marek@yahoo.de>
	<1238072366-8109-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1238072366-8109-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904010226.08922.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Don't detach batmand to background by
	default
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

On Thursday 26 March 2009 20:59:26 Sven Eckelmann wrote:
> This patch changes this behaviour to "not fork to the background unless
> said otherwise". The user can now use the option -B to explicit say
> that he knows what he is doing and that his system supports this
> combinations of fork+pthreads_create. All other systems can use
>  batmand tap1 > /dev/null 2>&1 &


Hi Sven,

thanks a lot for addressing this issue by sending your patch. Although I'm not 
too happy about the chosen approach. Changing the default behaviour and adding 
a new command line option seems not to be the best solution. Do you think we 
can put this exec call into batman itself and thus hiding this ulibc thread 
disaster ?

Regards,
Marek


