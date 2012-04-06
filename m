Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120406171940.GB12615@lunn.ch>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<20120323063206.GA5662@lunn.ch>
	<201204052330.06655.lindner_marek@yahoo.de>
	<20120406091320.GB10020@lunn.ch>
	<CAA_JP8VofnfLX7C7Bkfpbe1N6vqBiD3LV8N4U3seEw=NT9WnyQ@mail.gmail.com>
	<20120406171940.GB12615@lunn.ch>
Date: Fri, 6 Apr 2012 12:04:11 -0600
Message-ID: <CAA_JP8Xwo1C9c2NXNVPX5N0Li_04Cf4H0tvegLAn5CWafpqw-Q@mail.gmail.com>
From: dan <dandenson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [RFC] ELP
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

On Fri, Apr 6, 2012 at 11:19 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> disclaimer: I am an end user, not a dev. =A0I run a wISP (no mesh right
>> now, ringed). =A0Also, this is an evolved version of other ideas I
>> posted here.
>
> Hi Dan
>
> Are you talking about point to point links using highly directional
> antennas, or a bunch of omni directional systems all on the same
> channel interfering with each other?
>
> I've not yet looked at the details of what you said, but i get the
> feeling you are thinking about the first? Is that right?
>
> =A0 =A0Andrew

Andrew, ideally all link types.  If you are going to select path based
on both TQ AND capacity, or you are going to adjust TQ based on the
current criteria as well as capacity, all links matter right?

Highly directional p2p links are usually much more predictable than
the AdHoc cloud, so I would say the local AdHoc cloud is the target.
I have been looking at how to get the throughput on adhoc clouds but
it seems that most wireless adapters 'monitor' mode is exclusive, it
would take the link down to monitor the connection.  In adhoc, the
local nodes throughput isn't so important, because two other clients
might be saturating the airwaves.  Need to listen to all traffic on
the waves to see capacity.

If it was easy, someone else would have already done it right ;)
