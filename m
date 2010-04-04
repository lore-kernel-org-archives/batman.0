Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 4 Apr 2010 10:48:54 +0800
References: <201004040312.28481.sven.eckelmann@gmx.de>
	<1270345460-20555-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1270345460-20555-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201004041048.54962.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2-trunk] Staging: batman-adv: fix
	whitespace style issues
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Luis de Bethencourt <luisbg@ubuntu.com>

On Sunday 04 April 2010 09:44:20 Sven Eckelmann wrote:
> From: Luis de Bethencourt <luisbg@ubuntu.com>
> 
> This patch fixes the 31 unnecessary whitespaces before a quoted
> newline that the batman-adv files had.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@ubuntu.com>
> [sven.eckelmann@gmx.de: Redone to apply against current version]
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---
> Changes are done with "reorganized kernel interface patches (version 3)"
> applied.
>
> --- a/batman-adv-kernelland/bat_sysfs.c
> +++ b/batman-adv-kernelland/bat_sysfs.c
> @@ -77,7 +77,7 @@ static ssize_t show_aggr_ogm(struct kobject *kobj, struct
>  attribute *attr, struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
>         int aggr_status = atomic_read(&bat_priv->aggregation_enabled);
>  
> -       return sprintf(buff, "status: %s\ncommands: enable, disable, 0, 1
>  \n", +       return sprintf(buff, "status: %s\ncommands: enable, disable,
>  0, 1\n", aggr_status == 0 ? "disabled" : "enabled"); }

The whitespaces in bat_sysfs.c after the "commands" string are intentional. 
Userspace applications can simply split the string after each whitespace. Of 
course, it can be done differently but it only "costs" us a whitespace. I was 
not aware this would be an issue. Can we keep it or should we change e.g. 
batctl ?

Cheers,
Marek
