Return-Path: <gofb-b.a.t.m.a.n@m.gmane.org>
From: Ammar Anuar <ammaranuar87@gmail.com>
Date: Thu, 15 Aug 2013 01:25:36 +0000 (UTC)
Message-ID: <loom.20130815T031451-708@post.gmane.org>
References: <1375113404-10811-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.]
	=?utf-8?q?=5BPATCH-next=5D_batman-adv=3A_set_skb_p?=
	=?utf-8?q?riority_according=09to_content?=
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

Hi Simon,
Thank  you for your patch. I really appreciate your great work. I setup two 
nodes connecting each other using batman-adv. After applying this patch, I 
tried to use iptables to change the DSCP value and it properly mapped with 
access category. But the when I put batman interface (bat0) under bridge 
(br0), DSCP value no longer mapped with access category. The iptables 
command that I used is
iptables -t mangle -A POSTROUTING -s <source ip> -j DSCP --set-dscp <dscp 
value>
I'm still new in this field. Did I miss some command to pass the iptables 
command to the bridge? 
Thank you.



