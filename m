Return-Path: <gui@altermundi.net>
Message-ID: <53D05D84.20700@altermundi.net>
Date: Wed, 23 Jul 2014 22:12:36 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <53D00BAF.9070506@hachmer.de>
In-Reply-To: <53D00BAF.9070506@hachmer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] alfred - one gateway - multiple interfaces
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 23/07/14 16:23, Tobias Hachmer wrote:
> Hello list,
> 
> running here 3 gateways serving two communities. Nearly everything
> is duplicated/separated logically: fastd, bridges, routing tables,
> batman domains, etc.
> 
> Operating System is currently Ubuntu 14.04.
> 
> alfred: Installed: 2014.1.0-1 Candidate: 2014.1.0-1 Version table: 
> *** 2014.1.0-1 0 500 http://apt.rfc2324.org/debian/ wheezy/main
> amd64 Packages 100 /var/lib/dpkg/status
> 
> Guess what: We have the requirement to run one alfred instance for 
> each batman domain. What is the suggested way to achieve this?

a tangential question:

given you have a big enough hardware (since you mention ubuntu 14.04)
have you considered turning it into a "hardnode" and using any kind of
virtualization technology? openvz, lxc...

it would help with isolation and simplify things in the long run
(including having two alfred instances)

cheers!

gui

> For instance, I assume that this isn't intended by design because 
> /etc/default/alfred in conjunction with the init script aren't 
> multiple interface aware.
> 
> From our POV the preferred solution for this would be to patch the 
> init script in order to support multiple interfaces by reading
> this from /etc/default/alfred, like:
> 
> INTERFACES="bridge_one bridge_two" BATMANIFS="bat_one bat_two"
> 
> Just to fork multiple separated processes.
> 
> Maybe this is solved elsewhere and we didn't get it, yet.
> 
> Please give us your thoughts and hopefully a solution to this
> issue.
> 
> Regards, Tobias Hachmer
> 
