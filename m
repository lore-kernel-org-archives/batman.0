Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 5 Mar 2010 00:03:59 +0800
References: <20100303233946.GA24284@Linus-Debian>
	<20100304090355.GB29010@lunn.ch>
	<20100304160125.GA11797@Linus-Debian>
In-Reply-To: <20100304160125.GA11797@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201003050003.59714.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] vis packet format
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


Hi,

> Ah, okay, that makes sense. I was wondering about how the
> compatibility version would have to bedone anyway in such a case
> :D. So it should probably also be a general thing to better not
> change the compat-version during one merge window, right?

if you change the vis packet format we will need to increase the compat 
version, hence it will go into the development branch (gearing towards 0.3 at 
the moment). If your patch maintains compatibility it can be merged into the 
maint branch.

Regards,
Marek
