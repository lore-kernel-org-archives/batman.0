Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 9 Feb 2013 19:06:30 +0800
References: <1359916914-9798-1-git-send-email-ordex@autistici.org>
 <1359918139-12130-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1359918139-12130-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201302091906.31026.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [FIXv2] batman-adv: fix master setting in rtnl
	interface
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

On Monday, February 04, 2013 03:02:19 Antonio Quartulli wrote:
> To be merged with ("batman-adv: Allow to modify slaves of soft-interfaces
> through rntl_link")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2:
> - ndo_del_slave() also have to unset the master/upper_dev device

Did you actually test the stuff you are proposing ??
batctl if del <iface> results in a kernel crash ...

Cheers,
Marek
 
