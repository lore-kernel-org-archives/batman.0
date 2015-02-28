Return-Path: <gofb-b.a.t.m.a.n@m.gmane.org>
From: MK <mailing.m1@kkk-web.de>
Date: Sat, 28 Feb 2015 21:04:19 +0100
Message-ID: <mct705$mdf$1@ger.gmane.org>
References: <1424719130-2661-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Drop capabilities when not needed
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

Hi!

Thanks for the patch. Setup seems to be still working. How can I verify that 
privileges really dropped?

There are further questions:

Is _read_ access for the alfred user (resp. group) sufficient in 
/sys/kernel/debug/batman_adv/* ?
Or is write access on the socket file in this directory mandatory for full 
functionality?

Thanks 
Martin



