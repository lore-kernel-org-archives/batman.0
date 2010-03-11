Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 12 Mar 2010 03:20:04 +0800
References: <201003030640.16085.lindner_marek@yahoo.de>
	<20100309213501.GA30949@Linus-Debian>
In-Reply-To: <20100309213501.GA30949@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201003120320.04486.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] reorganized kernel interface patches (version 2)
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


Hey,

> those patches look quite good to me now, seems to work here as
> expected.

thanks for the review. Since there have been no further complains I committed 
the patches.


> Just one note: One of those warnings has gone now with the
> _GNU_SOURCE stuff. However, getline is also being used in
> funcitions.c:174 (so adding the define to functions.c too, got rid
> of the second warning for instance).

I made a seperate patch for the _GNU_SOURCE stuff as this does not really part 
of the sysfs conversion. 

Regards,
Marek
