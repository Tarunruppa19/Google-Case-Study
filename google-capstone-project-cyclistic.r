{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "bf236149",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2023-07-07T15:28:09.408253Z",
     "iopub.status.busy": "2023-07-07T15:28:09.406561Z",
     "iopub.status.idle": "2023-07-07T15:28:10.364974Z",
     "shell.execute_reply": "2023-07-07T15:28:10.363696Z"
    },
    "papermill": {
     "duration": 0.967616,
     "end_time": "2023-07-07T15:28:10.366964",
     "exception": false,
     "start_time": "2023-07-07T15:28:09.399348",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching core tidyverse packages\u001b[22m ──────────────────────── tidyverse 2.0.0 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mdplyr    \u001b[39m 1.1.2     \u001b[32m✔\u001b[39m \u001b[34mreadr    \u001b[39m 2.1.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mforcats  \u001b[39m 1.0.0     \u001b[32m✔\u001b[39m \u001b[34mstringr  \u001b[39m 1.5.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2  \u001b[39m 3.4.2     \u001b[32m✔\u001b[39m \u001b[34mtibble   \u001b[39m 3.2.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mlubridate\u001b[39m 1.9.2     \u001b[32m✔\u001b[39m \u001b[34mtidyr    \u001b[39m 1.3.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mpurrr    \u001b[39m 1.0.1     \n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\u001b[36mℹ\u001b[39m Use the conflicted package (\u001b[3m\u001b[34m<http://conflicted.r-lib.org/>\u001b[39m\u001b[23m) to force all conflicts to become errors\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "'cyclistic'"
      ],
      "text/latex": [
       "'cyclistic'"
      ],
      "text/markdown": [
       "'cyclistic'"
      ],
      "text/plain": [
       "[1] \"cyclistic\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# This R environment comes with many helpful analytics packages installed\n",
    "# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats\n",
    "# For example, here's a helpful package to load\n",
    "\n",
    "library(tidyverse) # metapackage of all tidyverse packages\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n",
    "\n",
    "list.files(path = \"../input\")\n",
    "\n",
    "# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using \"Save & Run All\" \n",
    "# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a0698b8b",
   "metadata": {
    "papermill": {
     "duration": 0.00458,
     "end_time": "2023-07-07T15:28:10.376566",
     "exception": false,
     "start_time": "2023-07-07T15:28:10.371986",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "---\n",
    "title: 'Case Study 1: Cyclistic'\n",
    "author: \"Carlos M. Muñoz Ebratt\"\n",
    "\n",
    "---\n",
    "\n",
    "# Introduction\n",
    "\n",
    "This notebook is part of Google Data Analysis Profesional Certificate.\n",
    "Course 8: Case Study - Cyclistic \n",
    "\n",
    "**Scenario**\n",
    "\n",
    "You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.\n",
    "\n",
    "**Characters and teams**\n",
    "Cyclistic: A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day.\n",
    "Lily Moreno: The director of marketing and my manager. Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program. These may include email, social media, and other channels.\n",
    "Cyclistic marketing analytics team: A team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.\n",
    "Cyclistic executive team: The executive team that will decide whether to approve the recommended marketing program.\n",
    "\n",
    "**About the company**\n",
    "In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that\n",
    "are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and\n",
    "returned to any other station in the system anytime.\n",
    "Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments.\n",
    "One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes,\n",
    "and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers\n",
    "who purchase annual memberships are Cyclistic members.\n",
    "Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the\n",
    "pricing flexibility helps Cyclistic attract more customers, Moreno believes that maximizing the number of annual members will\n",
    "be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a\n",
    "very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic\n",
    "program and have chosen Cyclistic for their mobility needs.\n",
    "Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to\n",
    "do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why\n",
    "casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are\n",
    "interested in analyzing the Cyclistic historical bike trip data to identify trends."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f5a5c47e",
   "metadata": {
    "papermill": {
     "duration": 0.004481,
     "end_time": "2023-07-07T15:28:10.385700",
     "exception": false,
     "start_time": "2023-07-07T15:28:10.381219",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# ASK\n",
    "\n",
    "The Marketing Director and Finance Analyst of the Organisation belive that annual members are more profitable than the Casual users.\n",
    "\n",
    "**key Objectives**\n",
    "1. As a Juinor data analyst, I have to identify How the annual riders or the members are different to the Causal Riders?\n",
    "2. Who are the Key Stakeholders?\n",
    "\n",
    "**Key Business Task**\n",
    "1. Identifty the Business Task:\n",
    "The company wants to improve their profits and they understands that the profits are highly generated from Annual Members. Inorder to increase the profits they want to convert the Casual Riders into Annual Members. For the same Reason, company wants to identify \"How the Causal riders differ from the Annual Members?\" \n",
    "\n",
    "2. Key StakeHolders:\n",
    "The Main Stakeholders of the project are Marketing Director- Lily Moreno, Cyclistic marketing analytics team, Cyclistic executive team.\n",
    "\n",
    "3. Business Task:\n",
    "The business task is to searching the differences between to users(Annual and Casual) for designing a marketing strategy to convert the Casual users to Annual Members. "
   ]
  },
  {
   "cell_type": "markdown",
   "id": "e548b63d",
   "metadata": {
    "papermill": {
     "duration": 0.005889,
     "end_time": "2023-07-07T15:28:10.396158",
     "exception": false,
     "start_time": "2023-07-07T15:28:10.390269",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Prepare\n",
    "**key Objective**\n",
    "The main objective is to check the credibility of the dataset.\n",
    "The Dataset used for this analysis is Cyclistic’s historical trip data which is publically available on Kaggle and can be downloded[here](https://divvy-tripdata.s3.amazonaws.com/index.html) as CSV.files."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "ca18d950",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:28:10.429811Z",
     "iopub.status.busy": "2023-07-07T15:28:10.407120Z",
     "iopub.status.idle": "2023-07-07T15:28:10.621077Z",
     "shell.execute_reply": "2023-07-07T15:28:10.619710Z"
    },
    "papermill": {
     "duration": 0.222144,
     "end_time": "2023-07-07T15:28:10.622923",
     "exception": false,
     "start_time": "2023-07-07T15:28:10.400779",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "The legacy packages maptools, rgdal, and rgeos, underpinning this package\n",
      "will retire shortly. Please refer to R-spatial evolution reports on\n",
      "https://r-spatial.org/r/2023/05/15/evolution4.html for details.\n",
      "This package is now running under evolution status 0 \n",
      "\n"
     ]
    }
   ],
   "source": [
    "library(tidyverse)\n",
    "library(\"dplyr\")\n",
    "library(\"ggplot2\")\n",
    "library(\"tidyr\")\n",
    "library(\"lubridate\")\n",
    "library(\"geosphere\")\n",
    "library(\"readr\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "873acfb6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:28:10.635080Z",
     "iopub.status.busy": "2023-07-07T15:28:10.633593Z",
     "iopub.status.idle": "2023-07-07T15:28:10.648453Z",
     "shell.execute_reply": "2023-07-07T15:28:10.647158Z"
    },
    "papermill": {
     "duration": 0.022398,
     "end_time": "2023-07-07T15:28:10.650135",
     "exception": false,
     "start_time": "2023-07-07T15:28:10.627737",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "'/kaggle/working'"
      ],
      "text/latex": [
       "'/kaggle/working'"
      ],
      "text/markdown": [
       "'/kaggle/working'"
      ],
      "text/plain": [
       "[1] \"/kaggle/working\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "getwd()\n",
    "setwd(\"/kaggle/working/\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "484f3b97",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:28:10.662671Z",
     "iopub.status.busy": "2023-07-07T15:28:10.661407Z",
     "iopub.status.idle": "2023-07-07T15:29:06.193786Z",
     "shell.execute_reply": "2023-07-07T15:29:06.192246Z"
    },
    "papermill": {
     "duration": 55.541629,
     "end_time": "2023-07-07T15:29:06.196656",
     "exception": false,
     "start_time": "2023-07-07T15:28:10.655027",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "#importing data\n",
    "data1 <- read.csv(\"/kaggle/input/cyclistic/202101-divvy-tripdata/202101-divvy-tripdata.csv\")\n",
    "data2 <- read.csv(\"/kaggle/input/cyclistic/202102-divvy-tripdata/202102-divvy-tripdata.csv\")\n",
    "data3 <- read.csv(\"/kaggle/input/cyclistic/202103-divvy-tripdata/202103-divvy-tripdata.csv\")\n",
    "data4 <- read.csv(\"/kaggle/input/cyclistic/202004-divvy-tripdata/202004-divvy-tripdata.csv\")\n",
    "data5 <- read.csv(\"/kaggle/input/cyclistic/202005-divvy-tripdata/202005-divvy-tripdata.csv\")\n",
    "data6 <- read.csv(\"/kaggle/input/cyclistic/202006-divvy-tripdata/202006-divvy-tripdata.csv\")\n",
    "data7 <- read.csv(\"/kaggle/input/cyclistic/202007-divvy-tripdata/202007-divvy-tripdata.csv\")\n",
    "data8 <- read.csv(\"/kaggle/input/cyclistic/202008-divvy-tripdata/202008-divvy-tripdata.csv\")\n",
    "data9 <- read.csv(\"/kaggle/input/cyclistic/202009-divvy-tripdata/202009-divvy-tripdata.csv\")\n",
    "data10 <- read.csv(\"/kaggle/input/cyclistic/202010-divvy-tripdata/202010-divvy-tripdata.csv\")\n",
    "data11 <- read.csv(\"/kaggle/input/cyclistic/202011-divvy-tripdata/202011-divvy-tripdata.csv\")\n",
    "data12 <- read.csv(\"/kaggle/input/cyclistic/202012-divvy-tripdata/202012-divvy-tripdata.csv\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "ba749f7a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:29:06.211212Z",
     "iopub.status.busy": "2023-07-07T15:29:06.210067Z",
     "iopub.status.idle": "2023-07-07T15:29:21.007524Z",
     "shell.execute_reply": "2023-07-07T15:29:21.006080Z"
    },
    "papermill": {
     "duration": 14.805732,
     "end_time": "2023-07-07T15:29:21.009402",
     "exception": false,
     "start_time": "2023-07-07T15:29:06.203670",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "trip <- rbind(data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "757dbf31",
   "metadata": {
    "papermill": {
     "duration": 0.004832,
     "end_time": "2023-07-07T15:29:21.019251",
     "exception": false,
     "start_time": "2023-07-07T15:29:21.014419",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Process"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "b98fafce",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:29:21.031901Z",
     "iopub.status.busy": "2023-07-07T15:29:21.030611Z",
     "iopub.status.idle": "2023-07-07T15:29:21.057028Z",
     "shell.execute_reply": "2023-07-07T15:29:21.055839Z"
    },
    "papermill": {
     "duration": 0.035242,
     "end_time": "2023-07-07T15:29:21.059321",
     "exception": false,
     "start_time": "2023-07-07T15:29:21.024079",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows: 3,489,748\n",
      "Columns: 13\n",
      "$ ride_id            \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"E19E6F1B8D4C42ED\", \"DC88F20C2C55F27F\", \"EC45C94683…\n",
      "$ rideable_type      \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"electric_bike\", \"electric_bike\", \"electric_bike\", …\n",
      "$ started_at         \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"2021-01-23 16:14:19\", \"2021-01-27 18:43:08\", \"2021…\n",
      "$ ended_at           \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"2021-01-23 16:24:44\", \"2021-01-27 18:47:12\", \"2021…\n",
      "$ start_station_name \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"California Ave & Cortez St\", \"California Ave & Cor…\n",
      "$ start_station_id   \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"17660\", \"17660\", \"17660\", \"17660\", \"17660\", \"17660…\n",
      "$ end_station_name   \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"Wood St & Augu…\n",
      "$ end_station_id     \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"657\", \"13258\",…\n",
      "$ start_lat          \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 41.90034, 41.90033, 41.90031, 41.90040, 41.90033, 4…\n",
      "$ start_lng          \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m -87.69674, -87.69671, -87.69664, -87.69666, -87.696…\n",
      "$ end_lat            \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 41.89000, 41.90000, 41.90000, 41.92000, 41.90000, 4…\n",
      "$ end_lng            \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m -87.72000, -87.69000, -87.70000, -87.69000, -87.700…\n",
      "$ member_casual      \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"member\", \"member\", \"member\", \"member\", \"casual\", \"…\n"
     ]
    }
   ],
   "source": [
    "#glimpse\n",
    "glimpse(trip)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "5399a229",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:29:21.071667Z",
     "iopub.status.busy": "2023-07-07T15:29:21.070581Z",
     "iopub.status.idle": "2023-07-07T15:29:25.407238Z",
     "shell.execute_reply": "2023-07-07T15:29:25.405661Z"
    },
    "papermill": {
     "duration": 4.344975,
     "end_time": "2023-07-07T15:29:25.409348",
     "exception": false,
     "start_time": "2023-07-07T15:29:21.064373",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "#dropping nullvalues\n",
    "trip_clean <- drop_na(trip)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "619da108",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:29:25.422226Z",
     "iopub.status.busy": "2023-07-07T15:29:25.420950Z",
     "iopub.status.idle": "2023-07-07T15:29:43.134479Z",
     "shell.execute_reply": "2023-07-07T15:29:43.132945Z"
    },
    "papermill": {
     "duration": 17.723403,
     "end_time": "2023-07-07T15:29:43.137772",
     "exception": false,
     "start_time": "2023-07-07T15:29:25.414369",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "trip_clean$date <- as.Date(trip_clean$started_at)\n",
    "trip_clean$year <- format(as.Date(trip_clean$started_at), \"%y\")\n",
    "trip_clean$month <- format(as.Date(trip_clean$started_at), \"%m\")\n",
    "trip_clean$day <- format(as.Date(trip_clean$started_at), \"%d\")\n",
    "trip_clean$day_of_week <- format(as.Date(trip_clean$started_at), \"%A\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "04a044f9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:29:43.150930Z",
     "iopub.status.busy": "2023-07-07T15:29:43.149712Z",
     "iopub.status.idle": "2023-07-07T15:30:03.491600Z",
     "shell.execute_reply": "2023-07-07T15:30:03.490170Z"
    },
    "papermill": {
     "duration": 20.351011,
     "end_time": "2023-07-07T15:30:03.494322",
     "exception": false,
     "start_time": "2023-07-07T15:29:43.143311",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# ride_length\n",
    "ride_length <- difftime(trip_clean$started_at, trip_clean$ended_at)\n",
    "\n",
    "#ride_distance\n",
    "ride_distance <- distGeo(matrix(c(trip_clean$start_lng, trip_clean$start_lat), ncol = 2), matrix(c(trip_clean$end_lng, trip_clean$end_lat), ncol = 2))\n",
    "ride_distance <- ride_distance/1000"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "3dea31f5",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:30:03.507816Z",
     "iopub.status.busy": "2023-07-07T15:30:03.506614Z",
     "iopub.status.idle": "2023-07-07T15:30:03.517799Z",
     "shell.execute_reply": "2023-07-07T15:30:03.516579Z"
    },
    "papermill": {
     "duration": 0.019842,
     "end_time": "2023-07-07T15:30:03.519876",
     "exception": false,
     "start_time": "2023-07-07T15:30:03.500034",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "#remove negatives\n",
    "trip_clean <- trip_clean[!trip_clean$ride_length < 1,]\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "03c26c8e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:30:03.533062Z",
     "iopub.status.busy": "2023-07-07T15:30:03.531781Z",
     "iopub.status.idle": "2023-07-07T15:30:03.597741Z",
     "shell.execute_reply": "2023-07-07T15:30:03.596284Z"
    },
    "papermill": {
     "duration": 0.074555,
     "end_time": "2023-07-07T15:30:03.599534",
     "exception": false,
     "start_time": "2023-07-07T15:30:03.524979",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "#finding the means\n",
    "# mean_ride_length\n",
    "user_mean <- trip_clean%>%\n",
    "group_by(member_casual)%>%\n",
    "summarise(mean_ride_length= mean(ride_length))\n",
    "#mean_distance\n",
    "mean_distance <- trip_clean%>%\n",
    "group_by(member_casual)%>%\n",
    "summarise(mean_ride_distance= mean(ride_distance))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "5d7fcc21",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:30:03.612563Z",
     "iopub.status.busy": "2023-07-07T15:30:03.611295Z",
     "iopub.status.idle": "2023-07-07T15:30:04.073770Z",
     "shell.execute_reply": "2023-07-07T15:30:04.072275Z"
    },
    "papermill": {
     "duration": 0.471532,
     "end_time": "2023-07-07T15:30:04.076113",
     "exception": false,
     "start_time": "2023-07-07T15:30:03.604581",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<pre class=language-r><code>function (x, center = TRUE, scale = TRUE) \n",
       "UseMethod(\"scale\")</code></pre>"
      ],
      "text/latex": [
       "\\begin{minted}{r}\n",
       "function (x, center = TRUE, scale = TRUE) \n",
       "UseMethod(\"scale\")\n",
       "\\end{minted}"
      ],
      "text/markdown": [
       "```r\n",
       "function (x, center = TRUE, scale = TRUE) \n",
       "UseMethod(\"scale\")\n",
       "```"
      ],
      "text/plain": [
       "function (x, center = TRUE, scale = TRUE) \n",
       "UseMethod(\"scale\")\n",
       "<bytecode: 0x5a4c49f67e40>\n",
       "<environment: namespace:base>"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nO3dd3yV5aHA8efNDgkQQlgOQBBFVIS6QEVUUNyodVEVtbZiRa2tKFav26vVuieO\n66h1tVpnsa3bVtxiW1EQBERF2RsCJDn3j2gMK5yEE6iP3+9fOe96HnPP5/Lrm3ckqVQqAADw\n/Ze1oScAAEBmCDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEisp7CbPe6YJEmS\nJCnd8oo1blRV3rUor3qzl+ctXQ+zOn3jpkmSjF1SsR7Gisy/r9oxSZJ+T01e7dolMx9PkiQr\nO++9hcvXdIT+LQqTJBn06tSGTeDtX22bpOHgf8147zc9kiTZr6EDAcD3SM56Hm/uhEvHLD5n\n6yarGXfOhEvGLV5jB/A9Ulj245+3K77rq4XnPPXZi8dsvuoGi76+68W55dm5La/r3bZhQxSU\ntd988/Kaj6mqRZ9O/CpJcjp37lh7s3b52Q07PgB8H63XsEuyclJVS8/++xcjD+m46tr3L/xT\nCCE3K1le5S1n33tn/mbbu8544/0LHwjHXLLq2nG33hZCaLX9Ne3yGnjOuPv5fxl//ncfy+eM\nLCw9ICu31fjx41factYRl93XdfbGXVs0bCAA+B5Zr9fYNd9seHaSvH3+n1ezLlVx7sjP85v1\n7leSvz6nRCPpPPjK7CSZN+nKd1f319gb7xofQuh39YD1MJOWPzro+OOP79+mcD2MBQAb1noN\nu7ymvYa1bzpn3AXjV7msbf6Ua95dsKz9wCuyQ7IuQ6QqFy9ZVrkuR8iM1NLpy6s29CQ2pPzm\nfc/u0CyVWj78yc9WWlU+57nfT1uUndvq2l5tNsjcavy3fFsAIEPW912xJ57fvapy8bBXVr6S\n/T//e38IYdBFPVfd5bN/PnTCIXts3LpFfpOSLtvueOolIyYsXqELx9+/e5IkJ42bfvfww1oX\nN2+Sn1PconWfQ095e2Z5CJUjbx7We6v2xfm5zco67HfCeas2ZSpV9ddbzu3TrWPTgrwWrTfp\nd/jJz/57Vn3nMPaOXZMkOe3TuQs/G3l0n27FeU0emL64Hr+XVMXzd1+8b6+tSpsWFJW07rHn\nYdc99u4K6yvnPXTtsH47dWvZvCgnr7DVplvsd8wZfxs7r/Y2b/yiW5IkP/541ko7JklS1OqI\n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\n7vOjVs2LsrNympZutMs+R9/65Oj6jlWvsEulUs8O7BhCyMnfZM7y1T+9eW2zWov1E3apNL4J\nALABJalUqsFn+/ivVbFo1qQvF3faYtPsDT0TAGC9EXYAAJHYMI87id7yeV9Pnbs0nS07dOjQ\n2JMBAH4gnLFrFB9csn3Pi99PZ0u/fwAgU4QdAEAkNthz7AAAyCxhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABCJRn9XbEVFxaJFixp7FACAH4jmzZuvaVWjh11VVdXy\n5csbexQAAPwpFgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEjn12nr+11NmLFq+6vLOnTtnaD4AADRQ\numG3ZMYLR/Qd9JePZ652bSqVytyUAABoiHTD7s6Djxs5ds7+p5yzz9btc5JGnRIAAA2RpHmy\n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\nwn777bFpWZOV1t11111r2s2fYgEAMigDz7H757m79LnqjRBCTn7BqjdPLFmyxjN5wg4AIIMy\nEHbdi/MmlQ58/h939OpQWq+xhR0AQAat6+NOUlWLPlxc0eeOK+tbdQAArDdp3TyRJDkd8rPn\nfDCjsWcDAECDpXdXbJL/7M3Hjb3xgBue+bBx3ywLAEBDpXuNXZ8+fb54783JSyryS9q0Ks5d\nae3nn3++ph1dYwcAkEEZeKVYWVlZ2YADe2RoQgAAZFz6z7FrIGfsAAAyKAOvFAMA4L+csAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIRJJKpTb0HAAAyABn7AAAIiHsAAAiIewAACIh7IDv\nnybZWV0GvbahZ/Ff7frOLZq0PHBDzwJY34QdAEAkhB0AQCSEHbBuUsuWVmTuqUmZPVoaqirm\n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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "$x\n",
       "[1] \"members_casual\"\n",
       "\n",
       "$y\n",
       "[1] \"mean_ride_distance\"\n",
       "\n",
       "$title\n",
       "[1] \"Member_causal Vs Distance\"\n",
       "\n",
       "attr(,\"class\")\n",
       "[1] \"labels\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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\n"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "#membersVstime\n",
    "ggplot(user_mean)+\n",
    "geom_col(aes(x= member_casual, y = mean_ride_length, fill= member_casual))+\n",
    "labs(title = \"Member_causal Vs Time\", x= \"members_casual\", y= \"mean_ride_length\")\n",
    "scale\n",
    "#memberVsdistance\n",
    "ggplot(mean_distance)+\n",
    "geom_col(mapping = aes(x= member_casual, y= mean_ride_distance, fill= member_casual))\n",
    "labs(title = \"Member_causal Vs Distance\", x= \"members_casual\", y= \"mean_ride_distance\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "127797ef",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:30:04.090910Z",
     "iopub.status.busy": "2023-07-07T15:30:04.089729Z",
     "iopub.status.idle": "2023-07-07T15:30:11.296940Z",
     "shell.execute_reply": "2023-07-07T15:30:11.295599Z"
    },
    "papermill": {
     "duration": 7.216739,
     "end_time": "2023-07-07T15:30:11.298967",
     "exception": false,
     "start_time": "2023-07-07T15:30:04.082228",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`summarise()` has grouped output by 'member_casual'. You can override using the\n",
      "`.groups` argument.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 14 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>member_casual</th><th scope=col>weekday</th><th scope=col>number_of_rides</th><th scope=col>average_duration</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;drtn&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>Sun</td><td>262861</td><td>-24.54683 secs</td></tr>\n",
       "\t<tr><td>casual</td><td>Mon</td><td>151460</td><td>-24.54683 secs</td></tr>\n",
       "\t<tr><td>casual</td><td>Tue</td><td>145660</td><td>-24.54683 secs</td></tr>\n",
       "\t<tr><td>casual</td><td>Wed</td><td>158691</td><td>-24.54683 secs</td></tr>\n",
       "\t<tr><td>casual</td><td>Thu</td><td>166672</td><td>-24.54683 secs</td></tr>\n",
       "\t<tr><td>casual</td><td>Fri</td><td>209131</td><td>-24.54683 secs</td></tr>\n",
       "\t<tr><td>casual</td><td>Sat</td><td>335901</td><td>-24.54683 secs</td></tr>\n",
       "\t<tr><td>member</td><td>Sun</td><td>266256</td><td>-24.54683 secs</td></tr>\n",
       "\t<tr><td>member</td><td>Mon</td><td>268096</td><td>-24.54683 secs</td></tr>\n",
       "\t<tr><td>member</td><td>Tue</td><td>285632</td><td>-24.54683 secs</td></tr>\n",
       "\t<tr><td>member</td><td>Wed</td><td>306113</td><td>-24.54683 secs</td></tr>\n",
       "\t<tr><td>member</td><td>Thu</td><td>301321</td><td>-24.54683 secs</td></tr>\n",
       "\t<tr><td>member</td><td>Fri</td><td>307671</td><td>-24.54683 secs</td></tr>\n",
       "\t<tr><td>member</td><td>Sat</td><td>324283</td><td>-24.54683 secs</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 14 × 4\n",
       "\\begin{tabular}{llll}\n",
       " member\\_casual & weekday & number\\_of\\_rides & average\\_duration\\\\\n",
       " <chr> & <ord> & <int> & <drtn>\\\\\n",
       "\\hline\n",
       "\t casual & Sun & 262861 & -24.54683 secs\\\\\n",
       "\t casual & Mon & 151460 & -24.54683 secs\\\\\n",
       "\t casual & Tue & 145660 & -24.54683 secs\\\\\n",
       "\t casual & Wed & 158691 & -24.54683 secs\\\\\n",
       "\t casual & Thu & 166672 & -24.54683 secs\\\\\n",
       "\t casual & Fri & 209131 & -24.54683 secs\\\\\n",
       "\t casual & Sat & 335901 & -24.54683 secs\\\\\n",
       "\t member & Sun & 266256 & -24.54683 secs\\\\\n",
       "\t member & Mon & 268096 & -24.54683 secs\\\\\n",
       "\t member & Tue & 285632 & -24.54683 secs\\\\\n",
       "\t member & Wed & 306113 & -24.54683 secs\\\\\n",
       "\t member & Thu & 301321 & -24.54683 secs\\\\\n",
       "\t member & Fri & 307671 & -24.54683 secs\\\\\n",
       "\t member & Sat & 324283 & -24.54683 secs\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 14 × 4\n",
       "\n",
       "| member_casual &lt;chr&gt; | weekday &lt;ord&gt; | number_of_rides &lt;int&gt; | average_duration &lt;drtn&gt; |\n",
       "|---|---|---|---|\n",
       "| casual | Sun | 262861 | -24.54683 secs |\n",
       "| casual | Mon | 151460 | -24.54683 secs |\n",
       "| casual | Tue | 145660 | -24.54683 secs |\n",
       "| casual | Wed | 158691 | -24.54683 secs |\n",
       "| casual | Thu | 166672 | -24.54683 secs |\n",
       "| casual | Fri | 209131 | -24.54683 secs |\n",
       "| casual | Sat | 335901 | -24.54683 secs |\n",
       "| member | Sun | 266256 | -24.54683 secs |\n",
       "| member | Mon | 268096 | -24.54683 secs |\n",
       "| member | Tue | 285632 | -24.54683 secs |\n",
       "| member | Wed | 306113 | -24.54683 secs |\n",
       "| member | Thu | 301321 | -24.54683 secs |\n",
       "| member | Fri | 307671 | -24.54683 secs |\n",
       "| member | Sat | 324283 | -24.54683 secs |\n",
       "\n"
      ],
      "text/plain": [
       "   member_casual weekday number_of_rides average_duration\n",
       "1  casual        Sun     262861          -24.54683 secs  \n",
       "2  casual        Mon     151460          -24.54683 secs  \n",
       "3  casual        Tue     145660          -24.54683 secs  \n",
       "4  casual        Wed     158691          -24.54683 secs  \n",
       "5  casual        Thu     166672          -24.54683 secs  \n",
       "6  casual        Fri     209131          -24.54683 secs  \n",
       "7  casual        Sat     335901          -24.54683 secs  \n",
       "8  member        Sun     266256          -24.54683 secs  \n",
       "9  member        Mon     268096          -24.54683 secs  \n",
       "10 member        Tue     285632          -24.54683 secs  \n",
       "11 member        Wed     306113          -24.54683 secs  \n",
       "12 member        Thu     301321          -24.54683 secs  \n",
       "13 member        Fri     307671          -24.54683 secs  \n",
       "14 member        Sat     324283          -24.54683 secs  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "trip %>% \n",
    "  mutate(weekday = wday(started_at, label = TRUE)) %>%\n",
    "  group_by(member_casual, weekday) %>%  \n",
    "  summarise(number_of_rides = n(), average_duration = mean(ride_length/60)) %>%\n",
    "  arrange(member_casual, weekday)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "78258a6c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:30:11.313506Z",
     "iopub.status.busy": "2023-07-07T15:30:11.312251Z",
     "iopub.status.idle": "2023-07-07T15:30:11.471793Z",
     "shell.execute_reply": "2023-07-07T15:30:11.470496Z"
    },
    "papermill": {
     "duration": 0.168731,
     "end_time": "2023-07-07T15:30:11.473678",
     "exception": false,
     "start_time": "2023-07-07T15:30:11.304947",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\n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\nAAAN18iTJ7588c9HHjX07XGzu2x+0J1/uWnbHiV1zenkCQCADMrkyRMLpg8768DNem7/uw+m\ntj3zjpfHvnVvPVUHAMBK06Dr2FW9cufZx/zhyrFlFZsdeNadt5zdu1neihoXAAANlG7YzRjx\n4nFHHXXf2+Oarj7o9jv+cvQ2a67QYQEA0FDL/ig2VTHtrrMP6tRnx7+/N+23Z9751cjXVR0A\nwM/QMo7YjX7lziOPOumNr2Z1HnDQo3+5cbuepStnWAAANFR9YXfOwQMvuv+drJyWx1x6x4VH\nb5MdKqdMmbLUOVu2bLlihgcAQLrqu9xJkiRpLqWehbjcCQBABtVzuZP6jtgdd9xxK2AwAACs\nEI28QHH6HLEDAMigTF6gGACAnydhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQiSSVSq3qMQAAkAGO2AEARELYAQBEQtgBAERC\n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\ngg=="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "#number of rides diferences by weekday:\n",
    "trip_clean %>% \n",
    "  mutate(weekday = wday(started_at, label = TRUE)) %>% \n",
    "  group_by(member_casual, weekday) %>% \n",
    "  summarise(number_of_rides = n(),average_duration = mean(ride_length),.groups = 'drop') %>% \n",
    "  arrange(member_casual, weekday)  %>% \n",
    "  ggplot() +\n",
    "  geom_col(aes(x = weekday, y = number_of_rides, fill = member_casual), position = \"dodge\") +\n",
    "  labs(title = \"Number of rides by User type during the week\",x=\"Days of the week\",y=\"Number of rides\",caption = \"Data by Motivate International Inc\", fill=\"User\") +\n",
    "  theme(legend.position=\"top\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "c1ba3fb2",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:30:11.489523Z",
     "iopub.status.busy": "2023-07-07T15:30:11.488307Z",
     "iopub.status.idle": "2023-07-07T15:30:11.505487Z",
     "shell.execute_reply": "2023-07-07T15:30:11.504144Z"
    },
    "papermill": {
     "duration": 0.027315,
     "end_time": "2023-07-07T15:30:11.507437",
     "exception": false,
     "start_time": "2023-07-07T15:30:11.480122",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "bike_type <- (trip_clean)%>%\n",
    "group_by(member_casual, rideable_type)%>%\n",
    "filter(rideable_type ==\"classic_bike\", rideable_type ==\"electric_bike\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "aefd6533",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:30:11.523438Z",
     "iopub.status.busy": "2023-07-07T15:30:11.522179Z",
     "iopub.status.idle": "2023-07-07T15:30:11.639627Z",
     "shell.execute_reply": "2023-07-07T15:30:11.638464Z"
    },
    "papermill": {
     "duration": 0.127624,
     "end_time": "2023-07-07T15:30:11.641620",
     "exception": false,
     "start_time": "2023-07-07T15:30:11.513996",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nO3deZxVdf348c+ZfZhhhmXYVBbZRATEHURFwX2lxJRUcqk0NdNCsCxzS1tc0rQs\n/WlqqZWm5tY3U8sS19RKXNAAF1T2RZYBZub+/hgZBxAYYIB893z+Nfdzls9nLj3q1bn3nMly\nuVwCAODTL29zLwAAgOYh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIYhOF3ezX\nj82yLMuyNttcutqd6qr7lBXV7/b4vCWbYFVf3bJllmWvLa7ZBHN9qv3rB7tkWTb8vimfuHXx\nzLuzLMvLL/rHgmWrO8O+rUuzLBv11/fWY/Znz+6fNcHh/5yxHidvojW/AwDwX6JgE883982L\nJiwau12LT5h3zpsXvr5otWXAf63SqiO/1Kn8hvcXjL3vrUeP7bnqDgs/uOHRudX5hW2vHNxx\nPc5fUtWlZ8/qhpe5uoX/mfR+lhX06NGt8W6divPXeqpc3cLxT71UUNxlt507r8dKAOC/3CYN\nuyyvIFe35Jw/vfvQiG6rbn3h/N+llArzsmV1/srZp8xZ3+x/w5lPvXD+benYC1fd+vp1P00p\ntdvp8k5F63OFeMB5D75x3scvq+c8VNrmkLzCdm+88ca6nqpm8cQ99tijost35r110XqsBAD+\ny23S79hVbj0uP8uePe/3n7AtV3PuQ+8UVwwe3qp4Uy6JZtFj9GX5WTZv8mXPf9KnsVff8EZK\nafgPD9jk6wKA/y2bNOyKWg4a06XlnNe/88YqX2ub//blz3+4tMsRl+anbEOmyNUuWry0dkPO\n0DxyS6Yvq9vci9h0iiuHntO1IpdbNu7et1baVD3n4VunLcwvbHfFoA6bZW0A8L9jU98Ve+J5\nA+pqF435y8pfov/3925JKY367g6rHvLW328/YcTeW7ZvXdyiVa/+u5x24fVvLlqhC9+4Za8s\ny05+ffqN4z7bvryyRXFBeev2e37m1GdnVqdU+9BPxgzetkt5cWFFVdeDTvjWqk2Zy9X98dpz\n9+zbrWVJUev2Ww0f+eUH/jVrXdfw2s+HZFl2xn/mLnjroWP27Fte1OK26Ys++S3I1Txy4wUH\nDtq2TcuSslbtB+7z2Svven7lXWrn3X7FmOG79m1bWVZQVNquc++Djj3z/16b17DDU1/pm2XZ\nka/OWumoLMvK2h3VeHD2yw+eOerAnp3aFhcWVbbdas9DT7zzmQ/Waa4mOvninVJKL3z3tpXG\nJ995SUqp3c6Xdyj8+D9sa13V+qr7668uO3yvAe1alReVVW7db/fTvnvDe0s+Cv07t60qKt8x\npTT/7YuzLGu7zc0NhzXXmwAAm1luk5j12udTSu0H3l899/G8LKsa8JOVdhjeqqSwrP+Sutwh\nbUpTSo/Nra4ff+qq0flZlmVZh259h+y2fVVZQUqpbMthj05b1HDsxF/umVLqM2KblNLW2w85\n4uBhnUsLUkplnY74yUkDs7zCfrsNP2zfIeX5eSmlDoMvazjwjC3KU0rf+9IOKaXC8g4Dd9im\nrCAvpZRXUHHxn95t2K0pa3j1+t1TSl984f8GVhSVdui978GH3Tdr8Se9EzWXHdUnpZSXX77D\noD136d+rIMtSSnuN+X3DHnU187+0a/uUUl5Bq+13Hjx09126tS5OKeUXdfrDjI9mHH/qtiml\nz74ys/Gp62rmppRaVI1sGJnxjytbFeSllNp0326PoXv07VZZP/U1r8xu+ly5XO6f3985pTTs\n3slr+CdeuuCl4rwsywqf/XBp4/Fzu1aklI7/+/tNX9WaLZ79YP0KV9109fHbp5SyLOvQvf9e\ng3duXZifUqrsefiEhctyudxLV1409hsnppSKK4ace+65F13xfNPfhKa8AwCw2W3qsMvlcmdu\n2TKvoGJKdU3D1gXv/TSltPWIh3O5FcJu3qSfFudlReX9f/HnN+v3rF0282dnDEopVfb8cu3y\nw+vDLssKx/3qufqRxdOf6lZSkFLKL2z3s8feqh+c8Y+fFmZZluVPXj51fdhlWf6Xrv3T0rpc\nLperXTLjutMHp5QKW2z7dnVN09dQH3btty4f9s3bF9XWre59eO0Xh6eUKnse9dzyKJz2wt3d\nSwqyLP+m9xbUj0x9/KiUUssuI1+b/VHd1tV8+PMTe6eU+o95tn6kiWE3pj6qbhi/fKD2/vN2\nSym13/HGps+Va3LW/GDbNimlfW6d2DCy9MMXCrMsv6jD9KUNb9XaV7Vmqwu7yXcfl1Iqrtzl\nvn/NXD77xK/v3Sml1PXQWz4aWfBCSqmiy3caH9iUN0HYAfCpsBnC7uWrB6WURv7540tiz50z\nIKV09oRZuRXD7uY9OqWUTvvLeyucq27Z8R3KUkrXv/9RCdWH3RZ73dJ4r9/t2D6ltN2Zf288\n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\nACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgB\nAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsA\ngCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcA\nEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAA\nghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBA\nEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAI\nQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABB\nCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAI\nYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh\n7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCE\nHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISw\nAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2\nAABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIO\nACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgB\nAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsA\ngCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcA\nEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAA\nghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBA\nEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAI\nQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABB\nCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAI\nYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh\n7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCE\nHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISw\nAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2\nAABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIO\nACCIgjVs69WrVxPP8sYbbzTHYgAAWH9rCrtu3bptqmUAALChslwut1EnWLp06fz58zfqFAAA\n/zuqqqpWt2lDv2OXq1s0/8NFG3gSAAA23IaG3bt//kzbdts2y1IAANgQa/qOXWO52gXXnvWl\nWx59ftbimsbjH7z9VlbadyMsDACAddPUK3YvXrT3mdfeOb/V1r071UyZMqXPgIHbD+hTMOu9\nrM0+P73vjxt1iQAANEVTr9h96ycT2va7ZOL483K1C7qXt97j2lvP69xy8fS/9tv64AVblG3U\nJQIA0BRNvWL3t/lLux1zaEopyy8/vn2Lx16YlVIqbT/01hO6XTLyho24QAAAmqapYde6IFv2\n4bL6n3fbqmzqfVPrf+762a3mvnnVRlkaAADroqlh98UtW7558/ffWVKbUup8+JbvPvSL+vEP\nHp22sZYGAMC6aGrYnXLTlxbP+H2Pqi6Tq2t7jP7ioum3DT5x7I8uOvvQK15us924jbpEAACa\noqk3T3Qa+sMX7+504c/vz8tSWadT7jjrrmN/fPnTuVxFjwPu+uMpG3WJAAA0xfr/SbH570yc\nvLCk7zZdCrM17eZPigEANKNm+JNigwcPvvzdBY1HKjr33r5Pl1lPnbnnsOM3aHUAADSHtXwU\nO3/ym+8vrU0pPf30091fffX1hRUrbs+9/OAT4/82ZWOtDgCAJlvLR7E3b9P2pImz13yKim6n\nz5t87eq2+igWAKAZreGj2LVcsdv9oiuvn1udUjr11FOHXnzVqHalK+2QV9hy8JEjN3yJAABs\noKbePLHPPvuM+PX9X9uifF0ncMUOAKAZreGK3brdFbto6kt33ffIK5PeW1Rb0Kn7dvuPGLlT\n57WknrADAGhGzRN2d59/zLHf++2Suo/3z/KKjzrv17+56Mg1HCXsAACaUTM87mTy744defFv\n2g896TePPDN1+qw5M9577rG7Tt67w28vHnn876c0zzIBANgATb1id/qWLW/NRk57+6YWeR8/\njzhXt+iLXTv+tu4LH079yeoOdMUOAKAZNcMVuztnLOr95a81rrqUUpbX4mtnbLN4xh0btDoA\nAJpDU8OuPC+velr1quPV06qz/HW+VRYAgGbX1LA7q1flm7ee9vycJY0Hl8574YwbJ1b2/NpG\nWBgAAOumqd+xm/v6T7ts99UlZb1OOuPEIQN6lqTF//n3+F9ee9PEBYXXvPzO6X1are5A37ED\nAGhGzfO4k3cf/8Vxp33rr6/Nahhps81e37vutlOHd1nDUcIOAKAZNdsDilPKvfvaPyb8570l\nqXiL7n133LbzWj/KFXYAAM2oGcJu8ODBR/7ukTFbrXyfxAfjzzzq23P+9thtqztQ2AEANKM1\nhF3Bmo+cP/nN95fWppSefvrp7q+++vrCihW3515+8Inxf5uy4UsEAGADreWK3c3btD1p4uw1\nn6Ki2+nzJl+7uq2u2AEANKP1v2K3+0VXXj+3OqV06qmnDr34qlHtSlfaIa+w5eAjR274EgEA\n2EBN/Y7dPvvsM+LX939ti3V+FrErdgAAzagZ74pdZ8IOAKAZNcPfigUA4L+csAMACELYAQAE\nIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAg\nhB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCE\nsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQ\ndgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDC\nDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELY\nAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7\nAIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEH\nABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewA\nAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0A\nQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMA\nCELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAA\nQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAg\nCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAE\nIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAg\nhB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCE\nsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQ\ndgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDC\nDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELY\nAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7\nAIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghHnz9FoAAAr6SURB\nVB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCE\nsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQ\ndgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDC\nDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELY\nAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7\nAIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEH\nABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewA\nAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0A\nQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMA\nCELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAA\nQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAg\nCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAE\nIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAg\nslwut7nXAABAM3DFDgAgCGEHABCEsAMACELYAZ96LfLzeo16YnOvYvO7qkfrFm0P3dyrADYn\nYQcAEISwAwAIQtgBzSq3dElN8z1EqXnP1gR1NXNrN+V8AM1K2AHN4M5tqyq7nv/cL76+VWV5\naVF+q/bdj/vWrXUpPf/LcTt061BaXL51390uuOOVxocseOuJs445oEu7VsVlbfrsMOzCnz9U\ntwFnSyn9667LhvbvWlZUXLVln1Ffu2Lq0tqmzJVSunmbtq17XLVk7rPH7d23vLjNgtq1p+T7\nT/76c/vt3LZlSYvKdoMOOvZ3z81ovPXVP1w3Yu8dqyrLCopKO/UY8IWx18xenqd1y2Zed+5J\nA3p0LCksrGjbefjRZz49s7rhwLGdKyo6j218qpcu3CnLsilLatd6ZoCUUsoBbLA7+rQtKOle\nVNj6xHMuuv6aHxzcp1VKaeej9yqt2vm8S6+58uKzu5YUZPmlf5u3pH7/BVPv6VFaWNii2wmn\nj7nku+OOGto9pTRw9M3rd7bSvKyy99D8vMIDjv7id847+/A9OqeUqgaesqh27XPlcrmberep\n6PLto7u23ve4M6+69mdL6tbyy77/t4vL8vNadNjt1G+cf/7YM/q1LckrbHPjpHn1W99+4LS8\nLGvVZ+8x51146YXfOW7/7VJKvY59oH7rFftumWX5w475ykWXXjrm1M+W5+eVdTpi6fIZz9mq\nZcutzmk814sX7JhSmlxds9Yz53K5K7u3Km1zyDr+0wGhCDugGdzRp21KacyjU+tfLp71QEop\nv3iLv8+prh958/ZhKaXPTZhZ//KC7doWtth2/MzFDWe45+sDU0qX/GfuepytNC9LKX3j969/\ndK66ZTed2i+l9Nn7pqx1rlwud1PvNlmWHfCTfzTpV61bsm/rktK2B766YOny5f2lTWFex0F3\n1L+8ZbuqgpIub1XXNBxx9pYtS9selsvlli16PS/Luhx0d8Om8efsXlVVdef0RfUv1xx2azhz\nPWEH+CgWaB6FLfr8aNgW9T+XtDmkZX5eVb8fD2lVXD/Sbvc9U0qLl9WllGoWTbj4ldl9vnLL\n4LYlDYcffP7VKaXf/Gziup6tXnmnL1/+md4fvcgKjr/qnhb5eX87/y9NmSullLLiW08Z2JRf\n88OpV/15TvVOP7y6T1nh8uUNvfdn137n5Kr6lyP//vq0917pUpxf/zJXt3BJLperXZRSyvJK\ni7I099XfP//Oh/VbB//wyRkzZhzdrrQpU6/hzAD1Cjb3AoAg8graNn5ZkKXidq0bXmZ5hQ0/\nV89+uDaX+/cVu2ZXrHySef+et65nq9e6/8gV9i/peUibkoem/a169oy1zpVSKiof2L6wSf9H\nd/4bj6eUhgzr0Hhwz5O/sufyn1u0ajP7uT/e8scnJkz8z1tvT3n1X/+cOndJSauUUsov7vx/\nlx1/6Ld+tWvXO7r22233QYP2GnbAUSP3b1OQNWXqNZwZoJ6wAza5vKKUUv+xNzVck2tQXNmk\ny2arWrWMCrKU5RU3ca4sr6yJE9UtqUspFWWrTbG7vzH8qKse33KHYYftM+jQIQd+46Ltp355\nvzOmf7R1r7G3TD/hm/fe+8Bfnvj7k4/88vYbrvr62YPuffnx/RpdUGwsV5dr4pkBkrADNr2S\nNgfnZ2fVzN3mgAN2bxisWfza3X/4Z8ftW6zfOWe/fG9K+zW8rF0y5f5Z1RWDh5e0GdC8c1X0\n3jGlR558dmbqWtEw+Ni4r9w2q/XNN1669MOnj77q8c4HX//WA19u2Hrz8h+WLXj9hQlz226/\n0zFfHnPMl8eklF59+OK+B5//tW+/+MrPBjesvfF0056fXf/Dms8MUM937IBNraCk5wV927xx\n2xce/eDj74fdcfoRo0aNent9/ztpwXs//daDk5a/qr19zBELauuO+OGQZp+rous3ty8veubM\nMZOrPyqwpfOeGn31DQ882z6lVLPotdpcrs3AnRr2X/T++CumfphSLqW0cNrPBg0a9Lnvv9iw\ntdvOu6SUahbW1L9skZ9XPfvBmcu/O1g96+nTHpta//OazwxQzxU7YDM466Gf3tD72IN69PvM\nMYfv1KvNy4/95rZHJvY/4bbj26/nFbvidiXfP7zvy8eetEuPli8+/tt7/jql8wEXXze4Q7PP\nleVX3ver03p95ur+PYeeeNwBHQvn3nPD9e/Xll131wkppRbtjtm37WmP/+jQMwrH7LRVi0kT\nnr7x+j/06Fiy9J0Xrvn170763AX7tvvFoxfvdfCkEwdt171u7pR7b7wpv7DtBZfuUH/yw4/v\nfeElz20/bPTY44Yt++C1X1559bSqovRuzVrPfPKokWV5TfqiHhDc5r4tF4jgjj5tiyuGNB5p\nXZDX5cBHGl7Of/uSlNJhL01vGJn7+h9PGTG0Y6vyohZt+gzc47s3PLysbj3PVpqX7fXrF278\n7pcGbt2xpKCoXZf+J337hnk1Hz+Pbg1z5XK5m3q3KWk1fJ1+3zcfvv7wPftVtCgsLmu947Cj\nbxv/fsOmBW//+QsH7rZl27KKjt33PuS4+yfMnvH8D7u1blFU3u7dJTWLPnjyq0fv26WqoiAv\nv2XbrYaOOPmeF2c2HFtXu/Dar4/apmvHwixLKW05ZPTfxx+Ulj/uZM1nznncCZDLZbmcy/gA\n/13qlsx/d0ZNl63abO6FAJ8ywg4AIAjfsQP42JR7Dt3hpCfXsENx5dAPpty7ydYDsE5csQMA\nCMLjTgAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABB/H94\nOdDrtVPDDQAAAABJRU5ErkJggg=="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(trip_clean)+\n",
    "geom_col(mapping= aes(x= member_casual, y = rideable_type, fill= member_casual))+\n",
    "labs(title= \"Member causal Vs Total\", x= \"member_casual\", y = \"total\")+\n",
    "theme(legend.position=\"top\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "2e0b0e28",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-07T15:30:11.657291Z",
     "iopub.status.busy": "2023-07-07T15:30:11.656136Z",
     "iopub.status.idle": "2023-07-07T15:30:11.787581Z",
     "shell.execute_reply": "2023-07-07T15:30:11.786264Z"
    },
    "papermill": {
     "duration": 0.141218,
     "end_time": "2023-07-07T15:30:11.789381",
     "exception": false,
     "start_time": "2023-07-07T15:30:11.648163",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 0 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>member_casual</th><th scope=col>rideable_type</th><th scope=col>total</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 0 × 3\n",
       "\\begin{tabular}{lll}\n",
       " member\\_casual & rideable\\_type & total\\\\\n",
       " <chr> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 0 × 3\n",
       "\n",
       "| member_casual &lt;chr&gt; | rideable_type &lt;chr&gt; | total &lt;int&gt; |\n",
       "|---|---|---|\n",
       "\n"
      ],
      "text/plain": [
       "     member_casual rideable_type total"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nO3deZxVdf348c+ZfZhhhmXYVBbZRATEHURFwX2lxJRUcqk0NdNCsCxzS1tc0rQs\n/WlqqZWm5tY3U8sS19RKXNAAF1T2RZYBZub+/hgZBxAYYIB893z+Nfdzls9nLj3q1bn3nMly\nuVwCAODTL29zLwAAgOYh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIYhOF3ezX\nj82yLMuyNttcutqd6qr7lBXV7/b4vCWbYFVf3bJllmWvLa7ZBHN9qv3rB7tkWTb8vimfuHXx\nzLuzLMvLL/rHgmWrO8O+rUuzLBv11/fWY/Znz+6fNcHh/5yxHidvojW/AwDwX6JgE883982L\nJiwau12LT5h3zpsXvr5otWXAf63SqiO/1Kn8hvcXjL3vrUeP7bnqDgs/uOHRudX5hW2vHNxx\nPc5fUtWlZ8/qhpe5uoX/mfR+lhX06NGt8W6divPXeqpc3cLxT71UUNxlt507r8dKAOC/3CYN\nuyyvIFe35Jw/vfvQiG6rbn3h/N+llArzsmV1/srZp8xZ3+x/w5lPvXD+benYC1fd+vp1P00p\ntdvp8k5F63OFeMB5D75x3scvq+c8VNrmkLzCdm+88ca6nqpm8cQ99tijost35r110XqsBAD+\ny23S79hVbj0uP8uePe/3n7AtV3PuQ+8UVwwe3qp4Uy6JZtFj9GX5WTZv8mXPf9KnsVff8EZK\nafgPD9jk6wKA/y2bNOyKWg4a06XlnNe/88YqX2ub//blz3+4tMsRl+anbEOmyNUuWry0dkPO\n0DxyS6Yvq9vci9h0iiuHntO1IpdbNu7et1baVD3n4VunLcwvbHfFoA6bZW0A8L9jU98Ve+J5\nA+pqF435y8pfov/3925JKY367g6rHvLW328/YcTeW7ZvXdyiVa/+u5x24fVvLlqhC9+4Za8s\ny05+ffqN4z7bvryyRXFBeev2e37m1GdnVqdU+9BPxgzetkt5cWFFVdeDTvjWqk2Zy9X98dpz\n9+zbrWVJUev2Ww0f+eUH/jVrXdfw2s+HZFl2xn/mLnjroWP27Fte1OK26Ys++S3I1Txy4wUH\nDtq2TcuSslbtB+7z2Svven7lXWrn3X7FmOG79m1bWVZQVNquc++Djj3z/16b17DDU1/pm2XZ\nka/OWumoLMvK2h3VeHD2yw+eOerAnp3aFhcWVbbdas9DT7zzmQ/Waa4mOvninVJKL3z3tpXG\nJ995SUqp3c6Xdyj8+D9sa13V+qr7668uO3yvAe1alReVVW7db/fTvnvDe0s+Cv07t60qKt8x\npTT/7YuzLGu7zc0NhzXXmwAAm1luk5j12udTSu0H3l899/G8LKsa8JOVdhjeqqSwrP+Sutwh\nbUpTSo/Nra4ff+qq0flZlmVZh259h+y2fVVZQUqpbMthj05b1HDsxF/umVLqM2KblNLW2w85\n4uBhnUsLUkplnY74yUkDs7zCfrsNP2zfIeX5eSmlDoMvazjwjC3KU0rf+9IOKaXC8g4Dd9im\nrCAvpZRXUHHxn95t2K0pa3j1+t1TSl984f8GVhSVdui978GH3Tdr8Se9EzWXHdUnpZSXX77D\noD136d+rIMtSSnuN+X3DHnU187+0a/uUUl5Bq+13Hjx09126tS5OKeUXdfrDjI9mHH/qtiml\nz74ys/Gp62rmppRaVI1sGJnxjytbFeSllNp0326PoXv07VZZP/U1r8xu+ly5XO6f3985pTTs\n3slr+CdeuuCl4rwsywqf/XBp4/Fzu1aklI7/+/tNX9WaLZ79YP0KV9109fHbp5SyLOvQvf9e\ng3duXZifUqrsefiEhctyudxLV1409hsnppSKK4ace+65F13xfNPfhKa8AwCw2W3qsMvlcmdu\n2TKvoGJKdU3D1gXv/TSltPWIh3O5FcJu3qSfFudlReX9f/HnN+v3rF0282dnDEopVfb8cu3y\nw+vDLssKx/3qufqRxdOf6lZSkFLKL2z3s8feqh+c8Y+fFmZZluVPXj51fdhlWf6Xrv3T0rpc\nLperXTLjutMHp5QKW2z7dnVN09dQH3btty4f9s3bF9XWre59eO0Xh6eUKnse9dzyKJz2wt3d\nSwqyLP+m9xbUj0x9/KiUUssuI1+b/VHd1tV8+PMTe6eU+o95tn6kiWE3pj6qbhi/fKD2/vN2\nSym13/HGps+Va3LW/GDbNimlfW6d2DCy9MMXCrMsv6jD9KUNb9XaV7Vmqwu7yXcfl1Iqrtzl\nvn/NXD77xK/v3Sml1PXQWz4aWfBCSqmiy3caH9iUN0HYAfCpsBnC7uWrB6WURv7540tiz50z\nIKV09oRZuRXD7uY9OqWUTvvLeyucq27Z8R3KUkrXv/9RCdWH3RZ73dJ4r9/t2D6ltN2Zf288\nOLpDWUrp4dkfXUurD7uuh/9qxcXWntG9MqV00N2Tmr6G+rBr0e7o2tyaDG9VkmXZ7VMXNB58\n6dKdUkq7Xvnv+pdv3nbWiBEjvvnnqY33mTtpTEqpy4GP1L9sYtj1Ki1MKb2xeFnDyNIFL15w\nwQWXXn5v0+fKNTlrptx/WEqpsvu3G0Ym3X1ASqnTHrc13m2tq1qz1YXdF7coTymd/eQHjQeX\nLXp1i+L8LK/kpQVLc6sJu6a8CcIOgE+FzRB29f/D3H6nXzRsPbKqRUFp9wW1dbkVwq5265KC\n/MKq6lWufz19xnYppaF3fnQJrT7sBl0zofE+j43YOqV0zIQV0ud73SpTSg+uGHbnTJyz0vmn\n/GG/lNIWez7Q9DXUh12fLz65hjdh8az7U0plHY5fabx26YwpU6ZMnVG9ugOrZ79141n91iPs\nxvZolVLqdtDpD46fsGS1lxHXMleuyVlTs3hSRUFelhU+M/+jT2N/3K9tSumEp1aIrfVYVWOf\nGHY1iyflZ1lBaY9lq5zw9p07pJSOf2lGbjVht6pV3wRhB8CnwqZ+QHFKqaT1wSd3LLv5n+Pe\nW3ryFkV5i2fceffMRZ33v7wsb4X7YWurJ0+urklpZkneJ98nO/+V+Y1f5n3SM9JaFK797pAR\nHVqsNNJm4D4pPbJo6mu11X3WaQ2td2q9homWzH0spVRadfhK43mFVV27VjUeqVk05dc33PbX\nZ158481JU96a8u709fwW/3cevfUf+41+9OHrDnn4usLy9jvsstseQ/cZcfQX9uzTptnnSinl\nl2z9o4FVpzw/fdw9Ux4f3at2ydvnvzYnv6jTj3Zut66rWldLP3y6Npcrb31QwSr/UL2GdUjP\nT3trwty0fdUnHZpSs74JALAZbYawSymdeda2/+/c58c8Pe32vTpNvPHylNJBl+2x0j653LKU\nUkFJtzFnHfOJJ+m4W7tPHF9X2SopkOUVpZSyvNJ1XUNB6Zrez1xddUopy1/Lez7rhRt3HXra\npAXLqnrttPegXfc6dFTP3n37df/LrrtduZbfJLfyA1bKux7259enPfenu//w0CNP/H38c088\n8Ozj91914djDzr3rvkuP2KC5VuOwK/Y9ZejtL15wSxp9ybRnxs6vqdtiryuqClbI67Wuar2s\n9qHWWX6WUqpbutqnzzT7mwAAm8vmCbteJ5+bzh35+Lg/pae+8JNrXssv6nTZgJWvphSU9GhX\nmD+7btGll122QY+2W5s/TF88uGVR45E5Ex5PKVVu16d511BUMSilny2e+WhKIxqP1yx+7Te/\n/0dxxeCRh3VPKZ1+8FmTFiw7+/bnrhy1c8M+86c8s9bzL1v8SX+JISva5YBRuxwwKqVUu3j6\no3fdeNzJ59///c/cfvbCz7crXe+5VqfD4Ks6Fv1m2pQfPPPh+W9+64mU0gE/HLauq1qPeYta\n7pafZdVz/lib0kp/WWzSX6allLbo12p1xzb7mwAAm8umfo5dvdKqIz/fvsWMF8a+M/3h//fB\nwva7/KjNqh+hZYXjtmlVu3T6ec9MX3FD3Rnb9+jUqdN9s6pXPmS9/GbsH1c6/4+/+mRKae9z\n+jbvGlq0G9WvrHDh+9c/OHNx4/FJd5xy3HHHffPOd1NKudp5v52+qKC4S+PISCnNn/jKqidc\nOG2F2af+6dLGLxdN/1WvXr0GDPp6w0h+afv9j//WNb1a53K5R+ZUr9NcTZRX2P6q3TvmcjVj\nf/evcc9Pzy/e4vKdVrioudZVrd+8+SU9RndoUbP4zXFPT2s8XrN44tdfmJnlFX1jm0/+lHxj\nvAkAsLlsnrBLKY05dZvapdOPOverKaVhP/ikizopjb751JTSFfvud+ez79eP5Go/vG3M8Ov+\nNWlJxeeOaFvSLCuZcs+xZ9zw1/oP6upq5vzirKFXTpxb2u7Aawd3aOY1ZIW3jNs1l6sZvfcp\n/561pH5szoQHD//qU1mWnXbJwJRSlt9y65L82qXv3DRhTsNxz9115b6feSClVLv86cqt+rdK\nKT1zygXTlv99izmv3HvYFx5qPFtJ6/3nvjX55WevOf++lxsGZ0544LuT52VZwegOLZo417oa\nfsXhKaXxXz1i6pLajoOvbLPi57BrXdX6TZpS+s7Vh6WUrj3oiIdenVs/UrNw0jcP3efdJTWd\nD7x+15aFDXvmaj/+ZuRGehMAYPPYNPdoNL4rtt7CabfULyCvoPV7Sz5+SMhKDyi+Z+x+9bt1\nG7Dr8H2G9KgqSSkVV+7w0AcLGw6pvyt29+tfbTxj/V2xJ01c4Zm3q94VW1DcZff2pSml4lZb\n7rJLv8qi/JRSQUm3W175+FbZpqyh/q7YPX85MbdGdbULx+zbOaWU5Zf2HjhkyE7b1d+WMfir\nv23YZ/z5Q1NKeflle+x/2OdGHLh97w55+eWjxp2bUsov6nTCV05fVFu3ZN6T9Q/qK6nqe/Bn\njtpn136leVlR+YD+ZYWN74p96sL961fevuf2w/YdvsuAnnlZllLa99z/a/pcuXW8J7SuZn7P\n5d81/OJz01bdYa2rWrPVP6C47spj+6eUsix/q2123GuXvuUFeSmlyp5HvLroo0er1C6bWf8U\n5QOOPObkM/7c9DfBXbEAfCpstrDL5XJHtC1NKbXf8eeNB1cKu1wu9+Ifrjtqv13btS4vKCzp\n0H3A57/2vQlzlzQ+ZEPCrrhiyLIFb17+9dEDunUsLSxs3aHroaO/8eQ7KzxnrilraGLY5XK5\nutpFv7967N4Du1eUFhaXVfbb/cDv3/rEirvUPnD1uMHbdSktyi9v3X73Q46791+zcrnctV8Y\nWllSUNa28/yaulwuN+eV+088dPf2FR99I6288553TJgzsqpF47DL5XJP/vqHh++5Y7vKsvy8\ngpZttth9/2Ouu/fFdZ1rXbPmgSO6pZQKireas+rTR5q0qjVZw1+eyOVqH73lkkOG9GvTsrSg\npGWXbQedev7Ppy5Z4dmCf/3+l7q2r8wrKOo9tCGm1/4mCDsAPhWyXG61txPyqVCzcNbkqYu6\n9+6cv/Z9AYDIhB0AQBCb7eYJAACal7ADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4A\nIAhhBwAQhLADAAhC2AEABCHsAACCKNjYE9TU1CxcuHBjzwIA8D+isrJydZs2etjV1dUtW7Zs\nY88CAICPYgEAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABB\nCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAI\nYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh\n7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCE\nHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISw\nAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2\nAABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIO\nACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgB\nAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsA\ngCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcA\nEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAA\nghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBA\nEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAI\nQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABB\nCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAI\nYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh\n7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCE\nHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISw\nAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2\nAABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIO\nACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgB\nAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsA\ngCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcA\nEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAA\nghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBA\nEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAI\nQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABB\nCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAI\nYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh\n7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCE\nHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISw\nAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2\nAABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIO\nACCIgjVs69WrVxPP8sYbbzTHYgAAWH9rCrtu3bptqmUAALChslwut1EnWLp06fz58zfqFAAA\n/zuqqqpWt2lDv2OXq1s0/8NFG3gSAAA23IaG3bt//kzbdts2y1IAANgQa/qOXWO52gXXnvWl\nWx59ftbimsbjH7z9VlbadyMsDACAddPUK3YvXrT3mdfeOb/V1r071UyZMqXPgIHbD+hTMOu9\nrM0+P73vjxt1iQAANEVTr9h96ycT2va7ZOL483K1C7qXt97j2lvP69xy8fS/9tv64AVblG3U\nJQIA0BRNvWL3t/lLux1zaEopyy8/vn2Lx16YlVIqbT/01hO6XTLyho24QAAAmqapYde6IFv2\n4bL6n3fbqmzqfVPrf+762a3mvnnVRlkaAADroqlh98UtW7558/ffWVKbUup8+JbvPvSL+vEP\nHp22sZYGAMC6aGrYnXLTlxbP+H2Pqi6Tq2t7jP7ioum3DT5x7I8uOvvQK15us924jbpEAACa\noqk3T3Qa+sMX7+504c/vz8tSWadT7jjrrmN/fPnTuVxFjwPu+uMpG3WJAAA0xfr/SbH570yc\nvLCk7zZdCrM17eZPigEANKNm+JNigwcPvvzdBY1HKjr33r5Pl1lPnbnnsOM3aHUAADSHtXwU\nO3/ym+8vrU0pPf30091fffX1hRUrbs+9/OAT4/82ZWOtDgCAJlvLR7E3b9P2pImz13yKim6n\nz5t87eq2+igWAKAZreGj2LVcsdv9oiuvn1udUjr11FOHXnzVqHalK+2QV9hy8JEjN3yJAABs\noKbePLHPPvuM+PX9X9uifF0ncMUOAKAZreGK3brdFbto6kt33ffIK5PeW1Rb0Kn7dvuPGLlT\n57WknrADAGhGzRN2d59/zLHf++2Suo/3z/KKjzrv17+56Mg1HCXsAACaUTM87mTy744defFv\n2g896TePPDN1+qw5M9577rG7Tt67w28vHnn876c0zzIBANgATb1id/qWLW/NRk57+6YWeR8/\njzhXt+iLXTv+tu4LH079yeoOdMUOAKAZNcMVuztnLOr95a81rrqUUpbX4mtnbLN4xh0btDoA\nAJpDU8OuPC+velr1quPV06qz/HW+VRYAgGbX1LA7q1flm7ee9vycJY0Hl8574YwbJ1b2/NpG\nWBgAAOumqd+xm/v6T7ts99UlZb1OOuPEIQN6lqTF//n3+F9ee9PEBYXXvPzO6X1are5A37ED\nAGhGzfO4k3cf/8Vxp33rr6/Nahhps81e37vutlOHd1nDUcIOAKAZNdsDilPKvfvaPyb8570l\nqXiL7n133LbzWj/KFXYAAM2oGcJu8ODBR/7ukTFbrXyfxAfjzzzq23P+9thtqztQ2AEANKM1\nhF3Bmo+cP/nN95fWppSefvrp7q+++vrCihW3515+8Inxf5uy4UsEAGADreWK3c3btD1p4uw1\nn6Ki2+nzJl+7uq2u2AEANKP1v2K3+0VXXj+3OqV06qmnDr34qlHtSlfaIa+w5eAjR274EgEA\n2EBN/Y7dPvvsM+LX939ti3V+FrErdgAAzagZ74pdZ8IOAKAZNcPfigUA4L+csAMACELYAQAE\nIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAg\nhB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCE\nsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQ\ndgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDC\nDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELY\nAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7\nAIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEH\nABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewA\nAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0A\nQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMA\nCELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAA\nQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAg\nCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAE\nIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAg\nhB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCE\nsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQ\ndgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDC\nDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELY\nAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7\nAIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghHnz9FoAAAr6SURB\nVB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCE\nsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQ\ndgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDC\nDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELY\nAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7\nAIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEH\nABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewA\nAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0A\nQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMA\nCELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAA\nQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAg\nCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAE\nIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAg\nslwut7nXAABAM3DFDgAgCGEHABCEsAMACELYAZ96LfLzeo16YnOvYvO7qkfrFm0P3dyrADYn\nYQcAEISwAwAIQtgBzSq3dElN8z1EqXnP1gR1NXNrN+V8AM1K2AHN4M5tqyq7nv/cL76+VWV5\naVF+q/bdj/vWrXUpPf/LcTt061BaXL51390uuOOVxocseOuJs445oEu7VsVlbfrsMOzCnz9U\ntwFnSyn9667LhvbvWlZUXLVln1Ffu2Lq0tqmzJVSunmbtq17XLVk7rPH7d23vLjNgtq1p+T7\nT/76c/vt3LZlSYvKdoMOOvZ3z81ovPXVP1w3Yu8dqyrLCopKO/UY8IWx18xenqd1y2Zed+5J\nA3p0LCksrGjbefjRZz49s7rhwLGdKyo6j218qpcu3CnLsilLatd6ZoCUUsoBbLA7+rQtKOle\nVNj6xHMuuv6aHxzcp1VKaeej9yqt2vm8S6+58uKzu5YUZPmlf5u3pH7/BVPv6VFaWNii2wmn\nj7nku+OOGto9pTRw9M3rd7bSvKyy99D8vMIDjv7id847+/A9OqeUqgaesqh27XPlcrmberep\n6PLto7u23ve4M6+69mdL6tbyy77/t4vL8vNadNjt1G+cf/7YM/q1LckrbHPjpHn1W99+4LS8\nLGvVZ+8x51146YXfOW7/7VJKvY59oH7rFftumWX5w475ykWXXjrm1M+W5+eVdTpi6fIZz9mq\nZcutzmk814sX7JhSmlxds9Yz53K5K7u3Km1zyDr+0wGhCDugGdzRp21KacyjU+tfLp71QEop\nv3iLv8+prh958/ZhKaXPTZhZ//KC7doWtth2/MzFDWe45+sDU0qX/GfuepytNC9LKX3j969/\ndK66ZTed2i+l9Nn7pqx1rlwud1PvNlmWHfCTfzTpV61bsm/rktK2B766YOny5f2lTWFex0F3\n1L+8ZbuqgpIub1XXNBxx9pYtS9selsvlli16PS/Luhx0d8Om8efsXlVVdef0RfUv1xx2azhz\nPWEH+CgWaB6FLfr8aNgW9T+XtDmkZX5eVb8fD2lVXD/Sbvc9U0qLl9WllGoWTbj4ldl9vnLL\n4LYlDYcffP7VKaXf/Gziup6tXnmnL1/+md4fvcgKjr/qnhb5eX87/y9NmSullLLiW08Z2JRf\n88OpV/15TvVOP7y6T1nh8uUNvfdn137n5Kr6lyP//vq0917pUpxf/zJXt3BJLperXZRSyvJK\ni7I099XfP//Oh/VbB//wyRkzZhzdrrQpU6/hzAD1Cjb3AoAg8graNn5ZkKXidq0bXmZ5hQ0/\nV89+uDaX+/cVu2ZXrHySef+et65nq9e6/8gV9i/peUibkoem/a169oy1zpVSKiof2L6wSf9H\nd/4bj6eUhgzr0Hhwz5O/sufyn1u0ajP7uT/e8scnJkz8z1tvT3n1X/+cOndJSauUUsov7vx/\nlx1/6Ld+tWvXO7r22233QYP2GnbAUSP3b1OQNWXqNZwZoJ6wAza5vKKUUv+xNzVck2tQXNmk\ny2arWrWMCrKU5RU3ca4sr6yJE9UtqUspFWWrTbG7vzH8qKse33KHYYftM+jQIQd+46Ltp355\nvzOmf7R1r7G3TD/hm/fe+8Bfnvj7k4/88vYbrvr62YPuffnx/RpdUGwsV5dr4pkBkrADNr2S\nNgfnZ2fVzN3mgAN2bxisWfza3X/4Z8ftW6zfOWe/fG9K+zW8rF0y5f5Z1RWDh5e0GdC8c1X0\n3jGlR558dmbqWtEw+Ni4r9w2q/XNN1669MOnj77q8c4HX//WA19u2Hrz8h+WLXj9hQlz226/\n0zFfHnPMl8eklF59+OK+B5//tW+/+MrPBjesvfF0056fXf/Dms8MUM937IBNraCk5wV927xx\n2xce/eDj74fdcfoRo0aNent9/ztpwXs//daDk5a/qr19zBELauuO+OGQZp+rous3ty8veubM\nMZOrPyqwpfOeGn31DQ882z6lVLPotdpcrs3AnRr2X/T++CumfphSLqW0cNrPBg0a9Lnvv9iw\ntdvOu6SUahbW1L9skZ9XPfvBmcu/O1g96+nTHpta//OazwxQzxU7YDM466Gf3tD72IN69PvM\nMYfv1KvNy4/95rZHJvY/4bbj26/nFbvidiXfP7zvy8eetEuPli8+/tt7/jql8wEXXze4Q7PP\nleVX3ver03p95ur+PYeeeNwBHQvn3nPD9e/Xll131wkppRbtjtm37WmP/+jQMwrH7LRVi0kT\nnr7x+j/06Fiy9J0Xrvn170763AX7tvvFoxfvdfCkEwdt171u7pR7b7wpv7DtBZfuUH/yw4/v\nfeElz20/bPTY44Yt++C1X1559bSqovRuzVrPfPKokWV5TfqiHhDc5r4tF4jgjj5tiyuGNB5p\nXZDX5cBHGl7Of/uSlNJhL01vGJn7+h9PGTG0Y6vyohZt+gzc47s3PLysbj3PVpqX7fXrF278\n7pcGbt2xpKCoXZf+J337hnk1Hz+Pbg1z5XK5m3q3KWk1fJ1+3zcfvv7wPftVtCgsLmu947Cj\nbxv/fsOmBW//+QsH7rZl27KKjt33PuS4+yfMnvH8D7u1blFU3u7dJTWLPnjyq0fv26WqoiAv\nv2XbrYaOOPmeF2c2HFtXu/Dar4/apmvHwixLKW05ZPTfxx+Ulj/uZM1nznncCZDLZbmcy/gA\n/13qlsx/d0ZNl63abO6FAJ8ywg4AIAjfsQP42JR7Dt3hpCfXsENx5dAPpty7ydYDsE5csQMA\nCMLjTgAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABB/H94\nOdDrtVPDDQAAAABJRU5ErkJggg=="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "bike_type%>%\n",
    "group_by(member_casual, rideable_type)%>%\n",
    "summarise(total=n(), .groups=\"drop\")\n",
    "ggplot(trip_clean)+\n",
    "geom_col(mapping= aes(x= member_casual, y = rideable_type, fill= member_casual))+\n",
    "labs(title= \"Member causal Vs Total\", x= \"member_casual\", y = \"total\")+\n",
    "theme(legend.position=\"top\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "bfc8006c",
   "metadata": {
    "papermill": {
     "duration": 0.006683,
     "end_time": "2023-07-07T15:30:11.802973",
     "exception": false,
     "start_time": "2023-07-07T15:30:11.796290",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**Analysis**\n",
    "From the above analysis, we can find that the average distance covered by casual users is almost same as the annual members. \n",
    "The usage of the bikes by the annual members is more on the week days and the casual riders on the weekends.\n",
    "we can see that the annual users can use both bike types. whereas, the casual riders can use only the electric bikes.\n",
    "The Annual users prefer to use Classic Bikes on the statring of the week and electic bikes on the ending of the week."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a178b1a9",
   "metadata": {
    "papermill": {
     "duration": 0.00668,
     "end_time": "2023-07-07T15:30:11.816278",
     "exception": false,
     "start_time": "2023-07-07T15:30:11.809598",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Share\n",
    "* We can conclude that, the usage of bikes by **Casual users** is more during the weekends and **Annual users** during the **week**.\n",
    "* The **Casual users** use **electric bikes** on the weekends.\n",
    "* The **Annual users** using the both the bike types during the **week days**.\n",
    "* Streeter Dr & Grand Ave are the most frequented station by casual users."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8819708f",
   "metadata": {
    "papermill": {
     "duration": 0.006682,
     "end_time": "2023-07-07T15:30:11.829527",
     "exception": false,
     "start_time": "2023-07-07T15:30:11.822845",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Act\n",
    "* The Company can start a visual ad campign focusing more on the Casual riders in between the Streeter Dr and Grand Ave stations.\n",
    "* Attracting the Casual riders by giving special discounts on annual members and free trails.\n",
    "* Making the casual riders know about How much they can save? and How benefical their services are?"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 125.589434,
   "end_time": "2023-07-07T15:30:12.056168",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2023-07-07T15:28:06.466734",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
