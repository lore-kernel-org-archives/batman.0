Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 24 Dec 2012 22:44:00 +0800
References: <CANiGF98hyN7yvSHNJ8zkicnZ4hJREYKEw7FPsL6JOEoT8ykvqw@mail.gmail.com>
In-Reply-To: <CANiGF98hyN7yvSHNJ8zkicnZ4hJREYKEw7FPsL6JOEoT8ykvqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201212242244.00358.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batctl: Fix undefined macro warning in manpage
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
Cc: Pau Koning <paukoning@gmail.com>

On Monday, December 24, 2012 22:38:21 Pau Koning wrote:
> A line beginning with ' or . in a groff file has a special meaning and
> cannot be used for literal text. Instead the interpreter will try to
> execute it and fail doing so. A zero-width space or reformatting the
> paragraph can be used as simple workaround.
> 
> This problem was detected using: LC_ALL=en_US.UTF-8 MANROFFSEQ=''
> MANWIDTH=80 man --warnings -E UTF-8 -l -Tutf8 -Z man/batctl.8
> 
> >/dev/null

Please send patches inline, so that they can be discussed and applied using 
git. Generally, considering the "Submitting patches" section on this page:
http://www.open-mesh.org/projects/open-mesh/wiki/Contribute
is a good idea.

Cheers,
Marek
