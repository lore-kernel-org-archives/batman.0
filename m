Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 23 Jul 2009 19:59:29 +0800
References: <20090718143250.GI4656@ma.tech.ascom.ch>
In-Reply-To: <20090718143250.GI4656@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907231959.55861.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [batman-adv] Cleanup aggregation.[ch]
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Saturday 18 July 2009 22:32:50 Andrew Lunn wrote:
> Make aggregation.[ch] clean with respect to the 2.6.29 checkpatch script.
>
> Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>

I applied your patch. 
I noticed you created a function for the calculcation of the hna length. It 
does not really do much. Would it make sense to transform it into a macro ?
While reviewing the code I saw multiple incarnations of the variable 
own_packet. Sometimes it is char, uint8_t or int. Not sure what effect it might 
have but I think it would be better to unify that ?!

Regards,
Marek

