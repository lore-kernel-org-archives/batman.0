From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 27 Sep 2008 00:03:23 +0800
References: <20080925191508.GA8854@sven-desktop.lazhur.ath.cx>
In-Reply-To: <20080925191508.GA8854@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809270003.23510.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Sync hash implementation of batgat and
	batman-adv
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

On Friday, 26. September 2008 03:15:08 Sven Eckelmann wrote:
> The compare functions had a different interpretation of its return value
> and kmalloc can sleep inside batgat because we are running in user context
> of kernel.

All your patches look very good - thanks (again) for your support. As far as I 
can see Simon already pushed them into the SVN. 

FYI: The different interpretation of the return value in the kernel space 
module is just a feeling thing. I thought that way it comes much easier to 
read and understand. No big deal actually - the code behaves the same 
way.  :-)

Greetings,
Marek
