Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 13 Apr 2012 23:04:23 +0200
References: <1334214449-3996-1-git-send-email-ordex@autistici.org>
	<1334214449-3996-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1334214449-3996-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201204132304.23485.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 3/3] batman-adv: use static inline
	functions to fake not compiled-in routines
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thursday, April 12, 2012 09:07:29 Antonio Quartulli wrote:
> In case of not compiled-in components, we need to fake some functions in
> order to let the rest of the code correctly build. But instead of using
> something like:
> 
> We have to use:
> 
> static inline bla_init(struct bat_priv *bat_priv)
> {
>         return 1;
> }
> 
> In this way the compiler can correctly check the type and the number of the
> arguments passed to the function, even if the related component (bla in
> this case) is not compiled.

The same needs to be done for DAT, right ?

Regards,
Marek
