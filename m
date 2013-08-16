Return-Path: <gofb-b.a.t.m.a.n@m.gmane.org>
From: Ammar Anuar <ammaranuar87@gmail.com>
Date: Fri, 16 Aug 2013 02:46:52 +0000 (UTC)
Message-ID: <loom.20130816T043455-405@post.gmane.org>
References: <1375113404-10811-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <loom.20130815T031451-708@post.gmane.org> <20130815122350.GA1588@pandem0nium>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH-next] batman-adv: set skb priority
	according?to content
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

I just figure out my mistake. Before I put batman interface (bat0) under 
bridge interface(br0), I accidentally load the older batman module that is why 
I cannot see any changes after manipulating DSCP value. It was a silly mistake 
btw. Now DSCP value perfectly mapped with access category after I load the 
right batman module (with your patch). Thank you Simon. 




