Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue,  7 Dec 2010 15:39:28 +0100
Message-Id: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] NDP patches, first draft
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

Hi everyone,

I've been working on those patches for seperating the link quality
measurements from the OGMs and putting that into a seperate protocol
with its own packets a little more. This Neighbour Discovery Protocol
will allow us to have faster intervals for NDP or different intervals
on different interface types, as well as creating individual convergence
speed optimizations for the link quality measurements (NDP) or the path
quality propagation (OGM) later.

This is a first draft and basically what we've been discussing on the
WBMv3 in Italy and which was documented a little in our wiki.

I haven't added my Signed-off-by yet as I'd like to get some feedback
first, especially for the last patch. Here I'm not sure if that's sufficient
and ok to do it like that (the limit check seemed redundant to me) or
if I'm missing something. Especially I'm not really sure what tq_own
was representing as the link quality seemed to be substracted with the
real_packet_count.

After the overall way of doing it is acknowledged, I'd start cleaning
up the OGM handling and removing variables and redundant LQ measurements.


Cheers, Linus
